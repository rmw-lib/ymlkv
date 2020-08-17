#!/usr/bin/env bash
set -e
DIR=$( dirname $(realpath "$0") )
cd $DIR/src
exe=index.coffee
nodemon --watch 'src/**/*' $exe ${@:1}

