FROM ubuntu

RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata gnupg postgresql postgresql-contrib python3-pip python-dev subversion sudo curl \
imagemagick build-essential patch  \
zlib1g-dev liblzma-dev libmagick++-dev passenger libcurl4-openssl-dev libssl-dev libpq-dev
RUN cd /opt
RUN svn co https://svn.redmine.org/redmine/branches/4.1-stable redmine-4.1
RUN ln -s redmine-* redmine
RUN mkdir -p /usr/src/sh
WORKDIR /usr/src/sh
COPY ./start.sh /usr/src/sh
RUN chmod a+x ./start.sh
ENTRYPOINT ["bash"]
RUN bash ./start.sh
EXPOSE 3000/tcp 