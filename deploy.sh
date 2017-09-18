#!/bin/bash

pid=$(ps aux | grep "petclinic" | grep "$SERVER_PORT" | awk '{print $2}')
kill $pid
echo "Deploying at port: $SERVER_PORT"
java -jar *.jar --server.port=$SERVER_PORT
