FROM node:18.16-slim as node

RUN npm install -g sass

FROM ruby:3.2.2-slim as base

RUN apt update -qq \
 && apt install -y graphviz vim \
 && apt install -y build-essential git libpq-dev \
 && apt clean \
 && rm -rf /var/lib/apt/lists/*

COPY --from=node /usr/local/include/ /usr/local/include/
COPY --from=node /usr/local/lib/ /usr/local/lib/
COPY --from=node /usr/local/bin/ /usr/local/bin/
# reset symlinks
RUN corepack disable && corepack enable

ARG APP_DIR
RUN mkdir ${APP_DIR}
WORKDIR ${APP_DIR}
