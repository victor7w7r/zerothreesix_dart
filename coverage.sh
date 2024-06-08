#!/bin/bash
export PATH="$PATH":"$HOME/.pub-cache/bin"
dart run test --coverage coverage
format_coverage --lcov --in=coverage --out=coverage/lcov.info --report-on=lib
genhtml -o coverage/html coverage/lcov.info
open coverage/html/index.html