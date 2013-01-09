# GiddyUp

Welcome to the exciting world of `giddyup`.

## What is GiddyUp?

GiddyUp is the visual scorecard for [riak_test](http://github.com/basho/riak_test).  GiddyUp provides two services, seeding ```riak_test``` with the list of tests which should be run for each platform, and receiving tests results and logs via a REST interface.

## Bootstrapping and Configuration

### You'll need postgres to get this working locally. Here's how!
1. Install Postgres. e.g. ```brew install postgresql```
2. Initialize Postgres ```initdb /usr/local/var/postgres -E utf8```
3. Start Postgres: ```pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start```
4. Create your dev database ```createdb giddyup_dev```
5. Test it out: ```psql -h localhost giddyup_dev```

Also, install this: get the [heroku-toolbelt](https://toolbelt.heroku.com)

### Here's how you get it running
1. Create a ```.env``` file with the following environment variables:
   ```DATABASE_URL```, ```S3_AKID```, ```S3_BUCKET``` and ```S3_SECRET```.
2. Migrate your database using ```foreman run rake db:migrate```
3. Seed your database with the default set of tests, platforms and
   backend combinations using ```foreman run rake db:seed```
4. Start your application with ```foreman start```

## Migrations
Want to add a new migration? try `bundle exec rake db:new_migration[MigrationName]`!

Fun Fact: zsh hates []'s. try adding `setopt nonomatch` to your .zshrc to make it love them, unless you are the yesnomatch type, in which case, run `noglob bundle exec rake db:new_migration[MigrationName]`. Don't say I did't warn you.

### How to test migrations?
Your best bet is to get the current heroku dataset with `pg_dump`. You need the heroku database url, which you can get with `heroku config` if you have access. If you don't, you shouldn't be doing this.

```
pg_dump postgres://whatever > heroku.sql
dropdb giddyup_dev
createdb giddyup_dev
psql giddyup_dev < heroku.sql
```

Once you start giddyup after that, you should have a mirror of production. Try out your migration now. the end.

## Screenshot

![Screenshot](https://raw.github.com/basho/giddyup/master/screenshot.png "Screenshot")
