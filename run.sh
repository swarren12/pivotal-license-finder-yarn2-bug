#!/bin/sh

DOCKER='docker'
LF_IMAGE='docker.io/licensefinder/license_finder:7.1.0'

check_licenses() {
    $DOCKER run --rm -v $PWD:/scan -w /scan -t "$LF_IMAGE" /bin/bash -lc "echo 'Running license finder...';
	    license_finder inherited_decisions add dependency_decisions.yml;
	    license_finder report --debug --recursive \
	    	--enabled-package-managers yarn bundler --prepare-no-fail \
		--format html --save /scan/report.html;
	    echo 'Done...'"
}


clean() {
    $DOCKER run --rm -v $PWD:/scan -w /scan -t "$LF_IMAGE" /bin/bash -lc "find \\( \
	        -name \"doc\" -o \
	    	-name \".bundle\" -o \
		-name \".yarn\" -o \
		-name \"node_modules\" -o \
		-name \"lf-bundle*\" -o \
		\\( -name \".yarnrc.yml\" -a ! -path \"./.yarnrc.yml\" \\) \
	    \\) -exec rm -rf '{}' \;"
}


case ${1:-check} in

  check) check_licenses && clean ;;
  clean) clean ;;

esac
