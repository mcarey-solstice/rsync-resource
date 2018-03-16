#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/../.init.sh

if [ ! -z ${hostname+x} ]; then
  unset hostname
fi

run ShouldThrow

# test_1
