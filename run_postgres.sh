#!/bin/bash
pg_ctlcluster 12 main start
groupadd postgresusers && usermod -aG postgresusers,sudo postgres && chgrp postgresusers /opt/
sudo -u postgres psql -c "CREATE ROLE redmine LOGIN ENCRYPTED PASSWORD 'super_strong_passwd_123' NOINHERIT VALID UNTIL 'infinity'"
sudo -u postgres psql -c "CREATE DATABASE redmine WITH ENCODING='UTF8' OWNER=redmine"