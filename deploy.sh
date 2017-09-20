#!/bin/bash

pid=$(pgrep -f "petclinic.*${SERVER_PORT}")
if [[ -n "$pid" ]] ; then
  kill "$pid"
fi

echo "Deploying at port: $SERVER_PORT"
java -jar ../dist/*.jar --server.port=$SERVER_PORT & sleep 5
