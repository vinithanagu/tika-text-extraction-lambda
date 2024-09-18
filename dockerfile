FROM public.ecr.aws/lambda/python:3.12

# Install Amazon Corretto 11 using microdnf
RUN microdnf install java-11-amazon-corretto

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-11-amazon-corretto

# Add the Java binaries to the PATH
ENV PATH="$JAVA_HOME/bin:$PATH"

# Install any dependencies required by your Lambda function
COPY requirements.txt  ${LAMBDA_TASK_ROOT}

COPY tika-server-1.24.jar  ${LAMBDA_TASK_ROOT}

user root

RUN pip install -r requirements.txt

# Copy your Lambda function code
COPY app.py ${LAMBDA_TASK_ROOT}

RUN chmod +x entrypoint.sh

ENTRYPOINT ["sh", "entrypoint.sh"]

EXPOSE 9998

CMD ["app.handler"]
