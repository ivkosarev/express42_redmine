FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y build-essential \
curl \
gnupg \
imagemagick \
libcurl4-openssl-dev \
liblzma-dev \
libmagick++-dev \
libpq-dev \
libssl-dev \
patch \
postgresql \
python-dev \
python3-pip \
subversion \
sudo \
tzdata \
zlib1g-dev \
&& rm -rf /var/lib/apt/lists/*

RUN cd /opt && svn co https://svn.redmine.org/redmine/branches/4.1-stable redmine-4.1 \
&& ln -s redmine-* redmine
COPY ./database.yml /opt/redmine-4.1/config/

WORKDIR /opt/redmine-4.1

COPY ./ruby.sh /usr/local/bin/
RUN chmod a+x /usr/local/bin/ruby.sh && bash /usr/local/bin/ruby.sh

EXPOSE 3000/tcp

COPY ./init.sh /usr/local/bin/
CMD chmod a+x /usr/local/bin/init.sh && bash /usr/local/bin/init.sh

