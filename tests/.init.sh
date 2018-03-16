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
__suite__() {
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
# Provides the path to the script that is to be run for that testing suite
##
__script__() {
  echo "$__DIR__"/../scripts/"$(__suite__)"
}

###
# Provides the file that can be logged to
#
# Parameters:
#   1 {string=log} The extension to attach to the file
##
__outfile__() {
  echo "$__OUT__"/"$(__suite__)"/"$(__caller__)".${1:-log}
}

###
# Runs setup for a run
##
_pre_run() {
  echo "Running $(__suite__)/$(__caller__)"

  mkdir -p "$__OUT__"/"$(__suite__)"
}

###
# Runs cleanup for a run
##
_post_run() {
  echo "$(__suite__)/$(__caller__) passed"
}

###
# Runs the main if defined.  If no main defined, the first parameter can be the name of a function that is defined and will be run with all parameters passed in.  If neither, the Default function is run
#
# Environment:
#   main {function} If defined, it will be the function to run
#
# Parameters:
#   1 {string} The function to run and all args passed to the function
##
run() {
  _pre_run

  local _fn="${1:-}"

  if [ "`type -t main`" = 'function' ]; then
    echo "Running main method"
    eval "main $@"
  elif [ "`type -t $_fn`" = 'function' ]; then
    echo "Running $_fn method"
    eval "$@"
  else
    echo "Running default method"
    Default
  fi

  _post_run
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
Default() {
  "$(__script__)" > "$(__outfile__ json)"
  EXT=json ShouldMatch
}

###
# Checks that two files are the same
#
# Environment:
#   EXT {string=log} The extension for default a and b
#
# Parameters:
#     The files to compare
#   1 {string=$__OUT__/$(__script__)/$(__caller__).$ext}
#   2 {string=$(__dir__)/$(__caller__).$ext}
##
ShouldMatch() {
  local ext="${EXT:-log}"
  local a="${1:-$(__outfile__ $ext)}"
  local b="${2:-$(__dir__)/$(__caller__).$ext}"

  echo "Comparing $a and $b"
  diff -q "$a" "$b"

  echo "$a and $b match"
}

###
# Checks that the script throws an error
##
ShouldThrow() {
  local outfile="$(__outfile__)"

  set +e

  "$(__script__)" > "$outfile"
  if [ $? -eq 0 ]; then
    echo "Expected $(__suite__) to exit with a nonzero status" 1>&2
    exit 255
  fi

  echo "$(__suite__) exited with a nonzero status"

  set -e
}

# tests
