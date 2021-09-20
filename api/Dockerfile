FROM ruby:2.6.6

RUN apt-get update -qq && apt-get -y install \
    build-essential \
    libpq-dev \
    default-mysql-client \
    nodejs 

RUN mkdir /app
ENV APP_ROOT /app
WORKDIR $APP_ROOT

ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

RUN gem install bundler && bundle install

EXPOSE 3000
