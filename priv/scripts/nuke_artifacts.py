#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Simple script to query the GiddyUp database and nuke the desired artifacts
# from S3

import psycopg2
import boto
import os

BASE = 'https://basho-giddyup.s3.amazonaws.com/'
baselen = len(BASE)

ENVVARS = ['AWS_ACCESS_KEY_ID',
           'AWS_SECRET_ACCESS_KEY',
           'GIDDYUP_PASSWORD']

for var in ENVVARS:
    if os.environ.get(var) is None:
        print("Environment variable {0} must be set".format(var))
        exit(1)

# Create an S3 session
# Set these environment variables:
#   AWS_ACCESS_KEY_ID - Your AWS Access Key ID
#   AWS_SECRET_ACCESS_KEY - Your AWS Secret Access Key
s3conn = boto.connect_s3()
bucket = s3conn.get_bucket('basho-giddyup')

# Connect to Postgres
# Set this environment variable:
#    GIDDYUP_PASSWORD
conn = psycopg2.connect(host='127.0.0.1',
                        dbname='giddyup',
                        user='giddyup',
                        password=os.environ['GIDDYUP_PASSWORD'])
cur = conn.cursor()

cur.execute("SELECT url,long_version "
            "FROM artifacts AS a, test_results AS tr "
            "WHERE a.test_result_id=tr.id AND "
            "(tr.scorecard_id IN"
            " (SELECT id"
            "  FROM scorecards"
            "  WHERE name LIKE '1.4.%' AND name <> '1.4.12' OR"
            "        name IN ('unknown','current')) "
            " OR (tr.long_version='riak_ee-2.1.2pre2'));")
while True:
    result = cur.fetchone()
    if result is None:
        break
    (url, version) = result
    k = boto.s3.key.Key(bucket)
    k.key = url[baselen:]
    print("Deleting {0} - {1}".format(version, url))
    k.delete()

cur.close()
conn.close()
