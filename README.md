# GiddyUp

Welcome to the exciting world of `giddyup`.

## What is GiddyUp?

GiddyUp is the visual scorecard for [riak_test](http://github.com/basho/riak_test).  GiddyUp provides two services, seeding ```riak_test``` with the list of tests which should be run for each platform, and receiving tests results and logs via a REST interface.

## Bootstrapping and Configuration

1. Migrate your database using ```bundle exec rake db:migrate```
2. Seed your database with the default set of tests, platforms and
   backend combinations using ```bundle exec rake db:seed```
3. Create a ```.env``` file with the following environment variables:
   ```DATABASE_URL```, ```S3_AKID```, ```S3_BUCKET``` and ```S3_SECRET```.
4. Start your application with ```foreman start```

## Screenshot

![Screenshot](https://raw.github.com/basho/giddyup/master/screenshot.png "Screenshot")
