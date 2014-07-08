#!/bin/sh
cd `dirname $0`
MODE="$1"
EXTRA_ARGS="$2"
if [[ "$MODE" = "dev" ]]; then
    EXTRA_ARGS="$EXTRA_ARGS -s reloader"
fi
exec erl -pa $PWD/ebin $PWD/deps/*/ebin -noshell -noinput -sname giddyup -config $MODE.config -s giddyup $EXTRA_ARGS
