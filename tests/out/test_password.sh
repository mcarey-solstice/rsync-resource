#!/bin/bash

source "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/../.init.sh

export hostname=server
export password=password

if [ ! -z ${sshkey+x} ]; then
  unset sshkey
fi

run

# test_1
