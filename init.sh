#!/bin/bash
pg_ctlcluster 12 main start
ruby bin/rails server -b 0.0.0.0 -e production