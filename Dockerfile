FROM ubuntu

RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive # подавляем запрос на инпут временной зоны при установке tzdata, которая нужна для постгри
RUN apt-get install -y tzdata gnupg 
RUN apt-get install -y postgresql postgresql-contrib python3-pip python-dev subversion sudo \
imagemagick ruby build-essential patch ruby-dev \
zlib1g-dev liblzma-dev libmagick++-dev passenger libcurl4-openssl-dev libssl-dev rubygems

WORKDIR /opt
RUN svn co https://svn.redmine.org/redmine/branches/4.1-stable redmine-4.1
RUN ln -s redmine-* redmine
RUN pg_ctlcluster 12 main start
RUN groupadd postgresusers && usermod -aG postgresusers,sudo postgres && chgrp postgresusers /opt/redmine
RUN sudo -i -u postgres
RUN psql -c "CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'super_strong_passwd_123' NOINHERIT VALID UNTIL 'infinity'"
RUN psql -c "CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine"
RUN exit
RUN cd /opt/redmine-4.1
RUN echo "production:" > config/database.yml
RUN echo " adapter: postgresql" >> config/database.yml
RUN echo " database: redmine" >> config/database.yml
RUN echo " host: localhost" >> config/database.yml
RUN echo " username: redmine" >> config/database.yml
RUN echo " password: super_strong_passwd_123" >> config/database.yml
 
RUN gem install bundler
RUN sudo -i -u postgres # перелогиниваемся потомучто бандлер просит не работать под рутом
RUN bundle config set without 'development test rmagick'
RUN bundle install











