#!/bin/sh
if [ -z "$PORT" ]; then
  export PORT="8001"
fi

./node_modules/.bin/coffee api.coffee &
sleep 5
PID=$!

./node_modules/.bin/dredd apiary.apib "http://localhost:$PORT/"
RESULT=$?

kill -9 $PID
exit $RESULT
