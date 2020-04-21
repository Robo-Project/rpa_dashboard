# DbBot report

## Found problems

Following problems were found when trying to save task related data with [DbBot-sqlalchemy](https://github.com/pbylicki/DbBot-SQLAlchemy). It is a fork from the original [dbbot](https://github.com/robotframework/DbBot)

Problems found when trying to log task related data with DbBot:

- DbBot is unable to log task related data to database
- At the moment the only way to log data is logging it with keyword. This means that data ends up in Messages table, that is related to keyword, in a column called text
- The problem is that a row in Keyword table is unique if the combination of name and type is unique
- This means that if we try to run task with the same keywords multiple times, only first one of these runs will be logged
- Also even if keywords table wouldn't have the unique constraint requirements, in order to have data that is well separable we would have to log a single row of data with a single keyword. For example, taxi drive length would be for example keyword called Return Taxi Drive Length which would result in complicated robofiles

[DbBot Schemas](https://github.com/pbylicki/DbBot-SQLAlchemy/blob/master/doc/robot_database.md)

Another issue:

- When running dbbot with keywords that have already been logged to database, dbbot fills log with errors such as:

```
postgres           | 2020-04-15 11:14:03.261 EEST [1576] ERROR:  duplicate key value violates unique constraint "unique_suites"

postgres           | 2020-04-15 11:14:03.261 EEST [1576] DETAIL:  Key (name, source)=(Tests, /opt/robotframework/tests) already exists.

postgres           | 2020-04-15 11:14:03.261 EEST [1576] STATEMENT:  INSERT INTO suites (id, suite_id, xml_id, name, source, doc) VALUES (nextval('suites_id_seq'), NULL, 's1', 'Tests', '/opt/robotframework/tests', '') RETURNING suites.id
```

Same occurs atleast with "unique_tests", "unique_keywords" and "unique arguments".

When continuously logging data from tasks, the whole log window will be filled with such errors.

## Solutions

Our solution to the first problem was following:

We created a separate databasesaver that creates a table for the fields in the task that we want to save and makes a connection to task metadata created by DbBot by foreign key to test_runs table. We are able to identify the correct test_runs row by calculating a sha1 hash of the source output.xml file using the same algorithm as dbbot uses.

```
def make_hash(xml_file):
    block_size = 68157440
    hasher = sha1()
    with open(xml_file, 'rb') as f:
        chunk = f.read(block_size)
        while len(chunk) > 0:
            hasher.update(chunk)
            chunk = f.read(block_size)
    return hasher.hexdigest()
```

For the task metadata to be separable from other tasks, this task **must** be run separately on its own robo-file. It is because foreign key is to test_runs and test_runs row presents one single robo-file.

Latter problem remains unsolved.