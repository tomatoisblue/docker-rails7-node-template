#!/bin/bash
set -e

rm -f /src/tmp/pids/server.pid

# Run the container main process which set as CMD in Dockerfile
exec "$@"
