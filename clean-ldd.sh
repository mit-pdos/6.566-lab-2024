#!/bin/bash

if [ $# -eq 0 ]; then
	echo "Usage: $0 BIN PORT"
	echo "clean-ldd runs the given server binary BIN using the configuration CONFIG in"
	echo "a pristine environment to ensure predictable memory layout between executions,"
        echo "and sets LD_TRACE_LOADED_OBJECTS=1 to print the shared library memory layout."
	exit 0
fi

ulimit -s unlimited

DIR=$(pwd -P)
if [ "$DIR" != /home/student/lab ]; then
    echo "========================================================"
    echo "WARNING: Lab directory is $DIR"
    echo "Make sure your lab is checked out at /home/student/lab or"
    echo "your solutions may not work when grading."
    echo "========================================================"
fi

exec env - PWD="$DIR" SHLVL=0 setarch "$(uname -m)" -R env LD_TRACE_LOADED_OBJECTS=1 "$@"

ERR=$?
echo Failed: exec env - PWD="$DIR" SHLVL=0 setarch "$(uname -m)" -R env LD_TRACE_LOADED_OBJECTS=1 "$@"
exit $ERR
