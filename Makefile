ERL ?= erl
APP := giddyup
OVERLAY_VARS    ?=

DIALYZER_APPS = kernel stdlib sasl erts ssl tools os_mon runtime_tools crypto inets \
		xmerl public_key asn1 mnesia eunit syntax_tools compiler

all: compile

.PHONY: deps rel stage

include tools.mk

compile: deps
	${REBAR} -r compile

deps:
	${REBAR} get-deps

update-deps:
	${REBAR} update-deps

clean:
	${REBAR} -r clean

distclean: clean
	${REBAR} delete-deps

generate:
	${REBAR} generate skip_deps=true $(OVERLAY_VARS)

rel: deps compile generate

stage: rel
	$(foreach dep,$(wildcard deps/*), rm -rf ${APP}/lib/$(shell basename $(dep))* && ln -sf $(abspath $(dep)) ${APP}/lib;)
