FROM public.ecr.aws/lambda/python:3.8

ENV PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on \
  PIP_DEFAULT_TIMEOUT=100 \
  POETRY_VERSION=1.1.7 \
  API_PYTHON_PATH="/var/task"

# System deps:
RUN pip install "poetry==$POETRY_VERSION"

COPY ./poetry.lock ./
COPY ./pyproject.toml ./
COPY ./app.py ./migrations/

# Project initialization:
RUN poetry config virtualenvs.create false \
  && poetry install --no-dev --no-interaction --no-ansi

COPY ./config ./migrations/config
COPY . ./migrations

COPY ./alembic/ ./alembic

RUN chmod 644 $(find . -type f)
RUN chmod 755 $(find . -type d)

CMD ["migrations/app.handler"]