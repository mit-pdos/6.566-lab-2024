#!/bin/sh
EXPECTED=$(cat unlinkaddr.txt)
ACTUAL=$(./clean-env.sh ./zookd --print-unlink-addr)
if [ "$EXPECTED" != "$ACTUAL" ]; then
    echo "WARNING: unlink address expected to be $EXPECTED but actually $ACTUAL."
    echo "WARNING: Your lab solutions are unlikely to work with the official grader."
    echo "WARNING: Contact course staff to resolve this; a likely cause is that you"
    echo "WARNING: installed some additional packages with unexpected shared libraries."
fi
