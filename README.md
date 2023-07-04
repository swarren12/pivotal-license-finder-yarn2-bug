# Pivotal License Finder // Yarn 2 Bug

Demonstrate a bug with Yarn 2 support in Pivotal license finder.

When attempting to scan projects recursively, Yarn 2 fails to resolve. 
This appears to be due to `yarn` running from the root directory, rather than the project sub-directory.

## Description

This example consists of three projects.
In theory, these would be interlinked, but for convenience they're standalone.

There is a "main" Ruby project and two JavaScript (Vue) sub-projects.

## Reproducing the Bug

Run the Pivotal License Finder as follows:

```shell
docker run --rm -v $PWD:/scan -w /scan licensefinder/license_finder:7.1.0 report --recursive --enabled-package-managers yarn bundler --prepare-no-fail --format html --save /scan/report.html
```
