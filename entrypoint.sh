#!/bin/sh

# Start the Tika server in the background
java -jar tika-server-standard-2.9.2.jar -p 9998 &

sleep 7

exec /var/runtime/bootstrap "$@"