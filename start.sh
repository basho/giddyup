#!/bin/sh
cd `dirname $0`
: ${CONF := "dev.config"}
exec erl -pa $PWD/ebin $PWD/deps/*/ebin -noshell -noinput -config $CONF -s giddyup
