FROM ruby:2.6.0-alpine

RUN apk update && apk upgrade && apk add alpine-sdk sqlite-dev

WORKDIR /app
COPY Gemfile .
RUN bundle install && bundle clean
COPY . /app
CMD ["ruby", "app.rb"]
