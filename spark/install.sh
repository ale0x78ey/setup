#!/bin/bash

sudo apt update && sudo apt install -y \
  openjdk-8-jdk                        \
  maven=3.6.0-1~18.04.1                \
  python3.6

sudo update-alternatives --install /usr/bin/python python \
                                   /usr/bin/python3.6 1

git clone https://github.com/apache/spark.git
cd spark/

# Spark v3.0.0-preview2-rc2
git checkout bcadd5c3096109878fe26fb0d57a9b7d6fdaa257
./build/mvn -DskipTests clean package
