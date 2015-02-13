# giddyup
Visual scorecard for riak_test which updates the [Giddyup](http://giddyup.basho.com) web page.  It runs as `ubuntu` on `app{1,2,3}.bos1` and lives in `/opt/giddyup`.  Data is stored in PostgreSQL on postgres2.bos1 and in Amazon S3.

## Configuration
Here are some configuration parameters set in the `ubuntu` environment:
```erlang
Port = env_or_default("PORT", "5000"),
IP = env_or_default("IP", "0.0.0.0"),
DB = env_or_default("DATABASE_URL", "postgres://localhost/giddyup_dev"),
AuthUser = env_or_default("AUTH_USER", "user"),
AuthPass = env_or_default("AUTH_PASSWORD", "pass"),
S3_AKID = os:getenv("S3_AKID"),
S3_BUCKET = env_or_default("S3_BUCKET", "basho-giddyup-dev"),
S3_SECRET = os:getenv("S3_SECRET"),
S3_HOST = env_or_default("S3_HOST", "s3.amazonaws.com"),
% next 2 used primarily by the coverge report script
Riak_ebins = generate_ebin_paths(env_or_default("RIAK_LIB_PATH", "")),
% this is a different config from the IP/Port above so that if the
% script that uses this config is running some other service that
% happens to have the same name, it doesn't conflict. Also, hostnames
% script that uses this config is running some other service that
% happens to have the same name, it doesn't conflict. Also, hostnames
% are nicer than ip's when talking to a webservice.
GiddyupUrl = env_or_default("GIDDYUP_URL", "http://localhost:5000"),
```
