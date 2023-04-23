FROM ruby:3.2.2
ARG APP_DIR

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim

RUN mkdir ${APP_DIR}
WORKDIR ${APP_DIR}

ADD Gemfile ${APP_DIR}/Gemfile
ADD Gemfile.lock ${APP_DIR}/Gemfile.lock
RUN bundle install
