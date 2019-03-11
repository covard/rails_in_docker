# base image
FROM ruby:2.6

# update packages
RUN apt-get update -yqq

# install node but only needed dependencies
RUN apt-get install -yqq --no-install-recommends nodejs

# copy app dir into /usr/src/app in container
COPY . /usr/src/app/

# this tells container to cd into app directory
WORKDIR /usr/src/app

# does this work?????
RUN bundle install

CMD ["bin/rails", "s", "-b", "0.0.0.0"]