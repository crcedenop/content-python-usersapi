# base image
FROM python:3.9-slim-buster

# working directory
WORKDIR /usr/src/app

# environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install system dependencies
RUN apt-get update \
  && apt-get -y install netcat gcc postgresql \
  && apt-get clean

# add/install requirements
COPY ./requirements.txt .
RUN pip install -r requirements.txt --use-feature=2020-resolver

# copy files
COPY . .

# run
COPY ./entrypoint.sh .
RUN chmod +x /usr/src/app/entrypoint.sh
