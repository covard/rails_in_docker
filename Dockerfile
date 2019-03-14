# base image
FROM ruby:2.6

LABEL maintainer="ovardcj@gmail.com"

# allow apt to work with https-based sources
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  apt-transport-https

# ensure we install an up to date version of node needs node >= 6.0.0
# see https://github.com/yarnpkg/yarn/issues/2888
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# ensure latest packages for yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  tee /etc/apt/sources.list.d/yarn.list

# install packages
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
  nodejs \
  yarn

# cache the gemfile seperate
COPY Gemfile* /usr/src/app/

# this tells container to cd into app directory
WORKDIR /usr/src/app

RUN bundle install

# copy app dir into /usr/src/app in container
COPY . /usr/src/app/

CMD ["bin/rails", "s", "-b", "0.0.0.0"]