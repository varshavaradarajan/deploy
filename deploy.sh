#!/bin/bash

count=0
while [ "$count" -lt 10 ]; do
    if [ "$(lsof -i "tcp:${SERVER_PORT}" | grep -q LISTEN; echo $?)" != "0" ]; then
        break
    fi
    echo "Waiting for port ${SERVER_PORT} to be free."
    pkill -f "petclinic.*${SERVER_PORT}"
    sleep 1
    count=$((count + 1))
done

echo "Deploying at port: $SERVER_PORT"
java -jar ../dist/*.jar --server.port=$SERVER_PORT & disown

sleep 10
