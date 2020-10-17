FROM ubuntu

RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive # подавляем запрос на инпут временной зоны при установке tzdata, которая нужна для постгри
RUN apt-get install -y tzdata gnupg 
RUN apt-get install -y postgresql postgresql-contrib python3-pip python-dev subversion sudo curl \
imagemagick build-essential patch  \
zlib1g-dev liblzma-dev libmagick++-dev passenger libcurl4-openssl-dev libssl-dev libpq-dev
WORKDIR /opt
RUN svn co https://svn.redmine.org/redmine/branches/4.1-stable redmine-4.1
RUN ln -s redmine-* redmine
RUN pg_ctlcluster 12 main start
RUN groupadd postgresusers && usermod -aG postgresusers,sudo postgres && chgrp postgresusers /opt/redmine*
RUN sudo -i -u postgres
RUN sudo -u postgres psql -c "CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'super_strong_passwd_123' NOINHERIT VALID UNTIL 'infinity'"
RUN sudo -u postgres psql -c "CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine"
RUN exit 
RUN cd /opt/redmine-4.1
RUN echo "production:" > config/database.yml                          rvm + bundler hook
RUN echo " adapter: postgresql" >> config/database.yml
RUN echo " database: redmine" >> config/database.yml
RUN echo " host: localhost" >> config/database.yml
RUN echo " username: redmine" >> config/database.yml
RUN echo " password: super_strong_passwd_123" >> config/database.yml
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN curl -sSL https://get.rvm.io | bash -s stable --ruby
RUN source /usr/local/rvm/scripts/rvm
RUN rvm install 2.6.5
RUN rvm use 2.6.5
RUN gem install bundler ему нада руби 2.3.0 или далее, сука!
RUN bundle config set without 'development test rmagick'
RUN bundle install
RUN bundle exec rake generate_secret_token
RUN RAILS_ENV=production bundle exec rake db:migrate
RUN RAILS_ENV=production REDMINE_LANG=ru bundle exec rake redmine:load_default_data
RUN ruby bin/rails server -b 0.0.0.0 -e production










