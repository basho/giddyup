#!/bin/sh
cd `dirname $0`
MODE="$1"
EXTRA_ARGS="$2"
if [[ "$MODE" = "dev" ]]; then
    EXTRA_ARGS="$EXTRA_ARGS -s reloader"
else
    EXTRA_ARGS="$EXTRA_ARGS -noshell -noinput -setcookie giddyup"
fi
exec erl -pa $PWD/ebin $PWD/deps/*/ebin -sname giddyup -config $MODE.config -s giddyup $EXTRA_ARGS
