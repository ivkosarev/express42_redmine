#!/bin/bash
gem install bundler 
bundle config set without 'development test rmagick'
cd /opt/redmine-4.1 && bundle install
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production REDMINE_LANG=ru bundle exec rake redmine:load_default_data