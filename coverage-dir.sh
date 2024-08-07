#!/bin/bash

if [ -z "$1" ]; then
  echo "Uso: $0 /ruta/a/test"
  exit 1
fi

TEST_DIR=$1

if [ ! -d "$TEST_DIR" ]; then
  echo "Error: $TEST_DIR no es un directorio válido"
  exit 1
fi

flutter test "$TEST_DIR" --coverage
dart run remove_from_coverage:remove_from_coverage -f coverage/lcov.info -r '\mappr.auto_mappr\.dart','\.g\.dart$'
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
