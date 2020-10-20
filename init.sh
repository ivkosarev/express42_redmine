#!/bin/bash
pg_ctlcluster 12 main start
groupadd postgresusers && usermod -aG postgresusers,sudo postgres && chgrp postgresusers /opt/
sudo -u postgres psql -c "CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'super_strong_passwd_123' NOINHERIT VALID UNTIL 'infinity'"
sudo -u postgres psql -c "CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine"
cd /opt/redmine-4.1 && bundle install
source /usr/local/rvm/scripts/rvm
rvm use 2.6.5
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production REDMINE_LANG=ru bundle exec rake redmine:load_default_data
ruby bin/rails server -b 0.0.0.0 -e production