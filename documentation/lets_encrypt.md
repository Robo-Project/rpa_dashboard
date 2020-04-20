# Let's Encrypt

## What is it?

Let's Encrypt is a free-to-use certificate authority.

If setting RPA Dashboard to a web server, setting up a certificate authority is considered standard procedure for webpage security.

## Setup

We did not create an automated setup, because it proved difficult for Ansible.

However, here are short rules how to do it.

This was taken from medium.com [blog post](https://medium.com/@pentacent/nginx-and-lets-encrypt-with-docker-in-less-than-5-minutes-b4b8a60d3a71)

There is an automated script, but I had trouble running it. Here the commands are used manually.

#### docker-compose.yml changes

Add new service to `docker-compose.yml`

```
  certbot:
    container_name: certbot
    image: certbot/certbot
    volumes:
      - ./data/certbot/conf:/etc/letsencrypt
      - ./data/certbot/www:/var/www/certbot
    entrypoint: "/bin/sh -c 'trap exit TERM; while :; do certbot renew; sleep 12h & wait $${!}; done;'"
```

Add new volumes to nginx in `docker-compose.yml`
```
  - ./data/certbot/conf:/etc/letsencrypt
  - ./data/certbot/www:/var/www/certbot
```

Add new command to nginx configuration to reload certificates in `docker-compose.yml`
```
  command: "/bin/sh -c 'while :; do sleep 6h & wait $${!}; nginx -s reload; done & nginx -g \"daemon off;\"'"
```

#### nginx.conf changes

Add this to `nginx.conf` to all `server` sections that have `listen 80` (grafana, jenkins, backend).
```
location /.well-known/acme-challenge/ {
    root /var/www/certbot;
}
```

Change all `ssl_certificate` and `ssl_certificate_key` paths to these:
```
ssl_certificate /etc/letsencrypt/live/example.org/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/example.org/privkey.pem;
```

Add these just before first `server`:
```
include /etc/letsencrypt/options-ssl-nginx.conf;
ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
```

#### commands to run

Define domains and e-mail
```
domains=(<domain1> <domain2> <domain3>)
domain_args="-d rpaboard.xyz -d jenkins.rpaboard.xyz -d backend.rpaboard.xyz"
In example, if your domain name is rpaboard.xyz:
domains=(rpaboard.xyz jenkins.rpaboard.xyz backend.rpaboard.xyz)
domain:args="-d rpaboard.xyz -d jenkins.rpaboard.xyz -d backend.rpaboard.xyz"
email=<your_email_here>
```

Create directory for new nginx config files and download them
```
mkdir -p "./data/certbot/conf"
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot-nginx/certbot_nginx/_internal/tls_configs/options-ssl-nginx.conf > "./data/certbot/conf/options-ssl-nginx.conf"
curl -s https://raw.githubusercontent.com/certbot/certbot/master/certbot/certbot/ssl-dhparams.pem > "./data/certbot/conf/ssl-dhparams.pem"
```

Create temporary certs for nginx
```
mkdir -p "./data/cerbot/conf/live/$domains"
docker-compose run --rm --entrypoint "\
  openssl req -x509 -nodes -newkey rsa:1024 -days 1\
    -keyout '/etc/letsencrypt/live/$domains/privkey.pem' \
    -out '/etc/letsencrypt/live/$domains/fullchain.pem' \
    -subj '/CN=localhost'" certbot
```

Start nginx to be able to generate Let's Encrypt query
```
docker-compose up --force-recreate -d nginx-proxy
```

Remove temporary certs from certbot
```
docker-compose run --rm --entrypoint "\
  rm -Rf /etc/letsencrypt/live/$domains && \
  rm -Rf /etc/letsencrypt/archive/$domains && \
  rm -Rf /etc/letsencrypt/renewal/$domains.conf" certbot
```

Request Let's Encrypt certificates
```

docker-compose run --rm --entrypoint "\
  certbot certonly --webroot -w /var/www/certbot \
    $staging_arg \
    --email=$email \
    $domain_args \
    --rsa-key-size $rsa_key_size \
    --agree-tos \
    --force-renewal" certbot

```

Reload nginx
```
docker-compose exec nginx-proxy nginx -s reload
```
