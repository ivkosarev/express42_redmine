#!/bin/bash
source /usr/local/rvm/scripts/rvm
rvm use 2.6.5
ruby bin/rails server -b 0.0.0.0 -e production