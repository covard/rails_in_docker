# base image
FROM ruby:2.6

# update packages
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs

# cache the gemfile seperate
COPY Gemfile* /usr/src/app/

# this tells container to cd into app directory
WORKDIR /usr/src/app

RUN bundle install

# copy app dir into /usr/src/app in container
COPY . /usr/src/app/

CMD ["bin/rails", "s", "-b", "0.0.0.0"]