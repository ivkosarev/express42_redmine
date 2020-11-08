#!/bin/bash
set -e
docker build -t  redmine_all_in_one .
docker tag redmine_all_in_one ivkosarev/redmine_all_in_one:latest

echo $my_passwd_docker | docker login --username ivkosarev --password-stdin

docker push ivkosarev/redmine_all_in_one:latest

if [ $? -eq 0 ]
then
  echo "Build Successfully Pushed!"
else
  echo "Something went wrong" >&2
fi
