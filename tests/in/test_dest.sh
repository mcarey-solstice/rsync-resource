#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/../.init.sh

export hostname=server
export from=foo.txt
export dest=bar.txt

run

# test_2
