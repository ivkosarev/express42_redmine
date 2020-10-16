sudo apt update
sudo apt install postgresql-12 postgresql-contrib \
postgresql-server-dev-12 imagemagick ruby build-essential \
patch ruby-dev zlib1g-dev liblzma-dev libmagick++-dev \
passenger libcurl4-openssl-dev libssl-dev \
python-pip python-dev subversion -y
cd ~
svn co https://svn.redmine.org/redmine/branches/4.1-stable redmine-4.1
