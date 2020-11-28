#!/bin/bash

sudo yum install java wget -y
sudo wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.0-linux-x86_64.tar.gz
sudo wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-7.10.0-linux-x86_64.tar.gz.sha512
sudo tar -xzf elasticsearch-7.10.0-linux-x86_64.tar.gz
sudo cd elasticsearch-7.10.0/
./bin/elasticsearch-keystore create -p
./bin/elasticsearch
./bin/elasticsearch-setup-passwords auto -u "http://localhost:9201"
