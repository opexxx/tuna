#!/bin/bash

EXPECTED_ARGS=1

if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: `basename $0` {dir}"
  exit 99
fi

DIR=$1
echo "Tuna directory: $DIR"

rake tuna:process TUNA_DIR=$DIR
