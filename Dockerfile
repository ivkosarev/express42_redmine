FROM ubuntu

RUN apt-get update

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get install -y tzdata gnupg postgresql postgresql-contrib python3-pip python-dev subversion sudo curl \
imagemagick build-essential patch  \
zlib1g-dev liblzma-dev libmagick++-dev passenger libcurl4-openssl-dev libssl-dev libpq-dev

RUN cd /opt && svn co https://svn.redmine.org/redmine/branches/4.1-stable redmine-4.1
RUN ln -s redmine-* redmine
COPY ./database.yml /opt/redmine-4.1/config/

COPY ./run_postgres.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/run_postgres.sh && bash /usr/local/bin/run_postgres.sh

COPY ./install_rvm.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/install_rvm.sh && bash /usr/local/bin/install_rvm.sh

COPY ./install_bundler_rake.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/install_bundler_rake.sh

RUN rake rails:update:bin --trace

EXPOSE 3000/tcp
 
CMD ruby bin/rails server -b 0.0.0.0 -e production

