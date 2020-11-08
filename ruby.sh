#!/bin/bash
gem install bundler 
bundle config set without 'development test rmagick'
cd /opt/redmine-4.1 && bundle install
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
source /usr/local/rvm/scripts/rvm
rvm use 2.6.5

