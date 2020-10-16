FROM ubuntu

RUN apt-get update
RUN apt-get install software-properties-common
RUN apt-add-repository universe
RUN apt-get update
RUN apt-get install python-pip

RUN apt-get install postgresql-12 postgresql-contrib \
postgresql-server-dev-12 imagemagick ruby build-essential \
patch ruby-dev zlib1g-dev liblzma-dev libmagick++-dev \
passenger libcurl4-openssl-dev libssl-dev \
python-pip python-dev  subversion -y

RUN cd ~

RUN svn co https://svn.redmine.org/redmine/branches/4.1-stable redmine-4.1

RUN ln -s redmine-* redmine

RUN postgres psql -c "CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD '$tr0ngP@$$123' NOINHERIT VALID UNTIL 'infinity'"

RUN postgres psql -c "CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine"

RUN cd ~/redmine

RUN echo "production:" > config/database.yml
RUN echo " adapter: postgresql" >> config/database.yml
RUN echo " database: redmine" >> config/database.yml
RUN echo " host: localhost" >> config/database.yml
RUN echo " username: redmine" >> config/database.yml
RUN echo " password: $tr0ngP@$$123" >> config/database.yml

RUN gem install bundler

RUN bundle config set without 'development test rmagick'

RUN bundle exec rake generate_secret_token

RUN RAILS_ENV=production bundle exec rake db:migrate

RUN RAILS_ENV=production REDMINE_LANG=ru bundle exec rake redmine:load_default_data

RUN gem install rmagick --no-ri --no-rdoc

RUN ruby bin/rails server -b 0.0.0.0 -e production












