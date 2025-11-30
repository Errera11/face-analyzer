FROM python:3.12-slim-bullseye AS prod

RUN apt-get update && apt-get install -y libgl1-mesa-glx

RUN apt-get update && apt-get install -y libglib2.0-dev


RUN pip install poetry==1.8.2

# Configuring poetry
RUN poetry config virtualenvs.create false
RUN poetry config cache-dir /tmp/poetry_cache

# Copying requirements of a project
COPY pyproject.toml poetry.lock /app/src/
WORKDIR /app/src

# Installing requirements
RUN --mount=type=cache,target=/tmp/poetry_cache poetry install --only main

# Copying actuall application
COPY . /app/src/
RUN --mount=type=cache,target=/tmp/poetry_cache poetry install --only main

CMD ["/usr/local/bin/python", "-m", "app"]

FROM prod AS dev

RUN --mount=type=cache,target=/tmp/poetry_cache poetry install
