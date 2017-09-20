#!/bin/bash

function wait_for_port_to_be {
    local should_kill="$1"
    local expected_status="$2"
    local status=1

    count=0
    while [ "$count" -lt 10 ]; do
        if [ "$(lsof -i "tcp:${SERVER_PORT}" | grep -q LISTEN; echo $?)" == "${expected_status}" ]; then
            status=0
            break
        fi
        echo "Waiting for port ${SERVER_PORT} to have status: ${expected_status} (0 = active, 1 = free)"
        if [ "$should_kill" = "true" ]; then pkill -f "petclinic.*${SERVER_PORT}"; fi
        sleep 1
        count=$((count + 1))
    done

    return "$status"
}

wait_for_port_to_be "true" 1

echo "Deploying at port: $SERVER_PORT"
java -jar ../dist/*.jar --server.port=$SERVER_PORT >deploy.log 2>&1 & disown

sleep 5

wait_for_port_to_be "false" 0
status="$?"

cat deploy.log

echo "Deployment status: $status"
exit "$status"
