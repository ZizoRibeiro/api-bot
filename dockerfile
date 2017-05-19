#FROM ruby:2.3-slim
FROM ruby:2.4.1-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential libpq-dev

ENV INSTALL_PATH /api-bot

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

#COPY Gemfile ./
COPY Gemfile Gemfile.lock ./

RUN bundle install

#ENV BUNDLE_PATH /box

COPY . .

CMD rackup config.ru -o 0.0.0.0
