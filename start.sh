#!/bin/bash
apt-get update
export DEBIAN_FRONTEND=noninteractive # подавляем запрос на инпут
apt-get install -y tzdata gnupg
apt-get install -y postgresql postgresql-contrib python3-pip python-dev subversion sudo curl \
imagemagick build-essential patch  \
zlib1g-dev liblzma-dev libmagick++-dev passenger libcurl4-openssl-dev libssl-dev libpq-dev
cd /opt
svn co https://svn.redmine.org/redmine/branches/4.1-stable redmine-4.1
ln -s redmine-* redmine
pg_ctlcluster 12 main start
groupadd postgresusers && usermod -aG postgresusers,sudo postgres && chgrp postgresusers /opt/
pg_ctl reload
sudo -u postgres psql -h localhost -c "CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'super_strong_passwd_123' NOINHERIT VALID UNTIL 'infinity'"
sudo -u postgres psql -h localhost -c "CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine"
cd /opt/redmine-4.1
echo "production:" > config/database.yml
echo " adapter: postgresql" >> config/database.yml
echo " database: redmine" >> config/database.yml
echo " host: localhost" >> config/database.yml
echo " username: redmine" >> config/database.yml
echo " password: super_strong_passwd_123" >> config/database.yml
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
rvm install 2.6.5
rvm use 2.6.5
gem install bundler 
bundle config set without 'development test rmagick'
bundle install
bundle exec rake generate_secret_token
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production REDMINE_LANG=ru bundle exec rake redmine:load_default_data
ruby bin/rails server -b 0.0.0.0 -e production

