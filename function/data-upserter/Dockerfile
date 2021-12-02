# Use base image tag with patch to resolve
# ECR scan vulnerabilities
FROM amazon/aws-lambda-python:3.8.2021.08.07.09

# Install poetry
RUN pip install poetry

# Copy poetry project
COPY poetry.lock pyproject.toml ${LAMBDA_TASK_ROOT}/

# Copy function code
COPY app.py ${LAMBDA_TASK_ROOT}/
COPY *.sql ${LAMBDA_TASK_ROOT}/

# Need to set the right permissions for lambda to execute. See https://docs.aws.amazon.com/lambda/latest/dg/troubleshooting-deployment.html
RUN chmod -R 755 ${LAMBDA_TASK_ROOT}

# Project initialization
RUN poetry config virtualenvs.create false \
  && poetry install --no-dev --no-interaction --no-ansi

# Set the CMD to your handler (could also be done as a parameter override outside of the Dockerfile)
CMD [ "app.handler" ]
