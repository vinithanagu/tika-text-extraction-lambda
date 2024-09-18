#!/bin/sh

# Start the Tika server in the background
java -jar tika-server-standard-${TIKA_VERSION}.jar -p 9998 &

sleep 8

#check if the AWS_LAMBDA_RUNTIME environment variable is set
# if [-z "${AWS_LAMBDA_RUNTIME_API}"]; then
#     exec /usr/local/bin/aws-lambda-rie  /usr/bin/python3 -m awslambdaric $@
# else
#     exec /usr/local/bin/python3 -m awslambdaric $@
# fi