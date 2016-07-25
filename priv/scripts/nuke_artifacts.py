#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Simple script to query the GiddyUp database and nuke the desired artifacts
# from S3

import psycopg2
import boto
import os

BASE = 'https://giddyup.basho.com.s3.amazonaws.com/'
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
bucket = s3conn.get_bucket('giddyup.basho.com')

# Connect to Postgres
# Set this environment variable:
#    GIDDYUP_PASSWORD
conn = psycopg2.connect(host='127.0.0.1',
                        dbname='giddyup',
                        user='giddyup',
                        password=os.environ['GIDDYUP_PASSWORD'])
cur = conn.cursor()

cur.execute("SELECT sc.id,url,long_version "
            "FROM artifacts AS a, test_results AS tr, scorecards AS sc, projects_tests AS tst "
            "WHERE a.test_result_id=tr.id AND tr.test_id=tst.test_id AND tst.project_id=2 AND "
            "tr.scorecard_id=sc.id AND "
            "sc.name IN ('riak_ee-ts_pb1','object_ttl_a1','43c71d91e4b92aa053716c7535914467905ab981','0.0.2')")
while True:
    result = cur.fetchone()
    if result is None:
        break
    (card, url, version) = result
    k = boto.s3.key.Key(bucket)
    k.key = url[baselen:]
    print("Deleting {0} - {1} - {2}".format(card, version, url))
    k.delete()

cur.close()
conn.close()
