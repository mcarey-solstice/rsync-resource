#!/bin/bash

set -eu

__DIR__="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

__OUT__="$__DIR__"/_output

###
# Provides the parent directory of the script that is calling this function
#
# Example:
#   tests/check/test_1.sh
#
#   Output: check
##
__script__() {
  echo $(basename "$( cd "$( dirname "${BASH_SOURCE[-1]}" )" && pwd )")
}

###
# Provides the name of the script that is calling this function
#
# Example:
#   tests/check/test_1.sh
#
#   Output: test_1
##
__caller__() {
  echo $(basename "${BASH_SOURCE[-1]}" .sh)
}

###
# Provides the full directory of the script that is calling this function
#
# Example:
#   tests/check/test_1.sh
#
#   Output: tests/check
##
__dir__() {
  echo "$( cd "$( dirname "${BASH_SOURCE[-1]}" )" && pwd )"
}

###
# Runs the test for the script that called this function.  It sends the output of that script to an output file and compares it with a json file in the same directory as the script.
#
# Example:
#   tests/check/test_1.sh
#
#   Calls the `../scripts/check` script and redirects the output to `tests/_output/check/test_1.json`
#   Then runs a diff against `tests/check/test_1.json`
##
run() {
  echo "Running $(__script__)/$(__caller__)"

  mkdir -p "$__OUT__"/"$(__script__)"

  "$__DIR__"/../scripts/"$(__script__)" 2> "$__OUT__"/"$(__script__)"/"$(__caller__)".json

  diff -q "$__OUT__"/"$(__script__)"/"$(__caller__)".json "$(__dir__)"/"$(__caller__)".json

  echo "$(__script__)/$(__caller__) passed"
}

# tests
