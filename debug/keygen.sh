#!/bin/sh

DIR="$( cd -P -- "$(dirname -- "$(command -v -- "$0")")" && pwd -P )"/.keys

mkdir -p "$DIR"

ssh-keygen -t rsa -f "$DIR"/key_rsa -N ''
