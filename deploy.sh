#!/bin/bash

pid=$(ps aux | grep "petclinic" | grep "$SERVER_PORT" | awk '{print $2}')
if [[ -n "$pid" ]] ; then
  kill $pid
fi

echo "Deploying at port: $SERVER_PORT"
java -jar ../dist/*.jar --server.port=$SERVER_PORT > /dev/null 2>&1 &
