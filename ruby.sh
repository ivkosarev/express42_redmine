#!/bin/bash
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
gem install bundler 
bundle config set without 'development test rmagick'
cd /opt/redmine-4.1 && bundle install
bundle exec rake generate_secret_token
groupadd postgresusers && usermod -aG postgresusers,sudo postgres && chgrp postgresusers /opt/

