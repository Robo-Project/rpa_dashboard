# Installation

## Deployment

If you have previously used rpa_dashboard, it's best to clear all volumes and images related to it to avoid conflicts.

### Localhost setup
Jenkins address 'jenkins.localhost' does not work unless you edit your '/etc/hosts' file.
Inside /etc/hosts add new line `127.0.0.1 *.localhost`, if it doesn't exist yet

If you're using localhost, the site will warn about connection not being private. This happens because we are using encrypted connection, but we do not have a certificate authority. It doesn't matter as we are using localhost connection. Press advanced and proceed to the site (in Chrome, other browsers might have different routine).

### Setup with ansible
Run all commands inside project directory

    # Setup to all servers defined in hosts.yml 
    ansible-playbook site.yml -i hosts.yml -u [username]`

    # limit setup to rpa1
    ansible-playbook site.yml -i hosts.yml --limit rpa1 -u [username]

    # setup in localhost
    ansible-playbook site.yml -i hosts.yml --connection=local --limit localhost

The setup will create `build` directory and copy necessary files there. If you want, you can manually choose the directory with the the extra-vars flag:
    
    ansible-playbook site.yml -i hosts.yml -u [username] --extra-vars="build_dir=/my_folder"

- Proceed to setup configuration.

## Configuration

If you are using internet domain, see [Setting up Lets Encrypt](lets_encrypt.md), to setup Lets Encrypt as certificate authority.

### Changing the default credentials for postgres and backend

Edit `.env` file to your liking to change login credentials.

In the file, the values are presented as `variable=value`, change the value in the following:

- BACKTOKEN
BACKTOKEN is the token that is checked when sending a request to the backend server. You can name it anything you want.
- POSTGRES_DB
POSTGRES_DB is the name for the Postgres database
- POSTGRES_USER
POSTGRES_USER is the name for the Postgres database user
- POSTGRES_PASSWORD
POSTGRES_PASSWORD is the password for the Postgres database user

* Do not change BACKURL.

### Jenkins configuration

#### First login

- Get password from console to unlock jenkins.
- Connect to jenkins.localhost (or jenkins.domain) with your browser.
- Log in with the password.
- Close the 'Customize Jenkins' window by pressing 'x' in the top right corner, plugins are already installed.
 
If you don't see the jenkins password in the console, you can get it from inside the jenkins container running this command:
`docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword`

#### Change admin password and generate API Token:

- Click 'admin' in top-right corner.
- Click 'Configure' in left menu.
- Under Api Token, choose Add new Token, and press Generate.
- Edit file 'jenkins-api-token' in build directory. Write username and token there as `<username>:<token>` such as `admin:token`, where token is the newly generated token. Make sure there are no extra lines in the file, but the file should end with end-of-line mark. Save the file.
- Input new password to 'Password' and 'Confirm Password' fields.
- Save.
- Log in with new password.
 
#### Define Jenkins security:

- Click 'Manage Jenkins'
- Click 'Configure Global Security'
- Under Strategy, Authorization, sSelect 'Logged-in users can do anything'
- Uncheck "Allow anonymous read access"
- Save

### Grafana configuration

- Connect to localhost (or domain).
- log in with username `admin` and password `admin`.
- Change the admin password.
- From left side bar, move mouse over the gear icon and click 'Data Sources'
- Click 'PostgreSQL'
- Set username, password and database to same ones as in the '.env' file.
- Click 'Save & Test'


### Setting up your first job
[Setting up jobs and launching them](manual.md)
