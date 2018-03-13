#!/bin/bash

###
# Runs the entire testing suite
##

__DIR__="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Collect all the tests
TESTS=$(find "$__DIR__" -name 'test_*.sh')
count=$(echo "$TESTS" | wc -l)
status=0

echo "Found $count tests"

i=1
for t in $TESTS; do
  echo "Running $t ($i/$count)"
  echo "---------------------------"
  echo "Output:"
  "$t"
  exit_code=$?
  echo "---------------------------"

  if [ $exit_code -eq 0 ]; then
    echo "Success!"
  else
    echo "Failure!"

    status=$((status+1))
  fi

  echo ""

  i=$((i+1))
done

success=$(($count - $status))

echo ""
echo "Results:"
echo " $success/$count Successful"
echo " $status/$count Failed"
echo ""

exit $status

# tests.run
