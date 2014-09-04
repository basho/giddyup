ERL ?= erl
APP := giddyup

DIALYZER_APPS = kernel stdlib sasl erts ssl tools os_mon runtime_tools crypto inets \
		xmerl public_key asn1 mnesia eunit syntax_tools compiler

all: compile script

.PHONY: deps compile update-deps clean distclean

include tools.mk

compile: deps assets
	${REBAR} -r compile

deps:
	${REBAR} get-deps

update-deps:
	${REBAR} update-deps

clean:
	${REBAR} -r clean

distclean: clean
	${REBAR} delete-deps

script: compile
	${REBAR} escriptize

include assets.mk
