#!/bin/bash
source /usr/local/rvm/scripts/rvm
rvm use 2.6.5
rake app:update:bin
pg_ctlcluster 12 main start
ruby bin/rails server -b 0.0.0.0 -e production