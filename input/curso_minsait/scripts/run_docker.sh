#!/bin/bash

# Dockers na máquina local

# 12afb3fffd8d   fjardim/hive             "entrypoint.sh /bin/…"   6 days ago     Exited (137) 15 minutes ago             hive-server
# 3123eb553599   fjardim/hive             "entrypoint.sh /opt/…"   6 days ago     Exited (143) 14 minutes ago             hive_metastore
# 5cd57c1fa777   fjardim/hive-metastore   "/docker-entrypoint.…"   6 days ago     Exited (0) 14 minutes ago               hive-metastore-postgresql
# 6853d37af723   fjardim/datanode         "/entrypoint.sh /run…"   6 days ago     Exited (137) 13 minutes ago             datanode
# 5cdfc90cde5a   fjardim/namenode_sqoop   "/entrypoint.sh /run…"   6 days ago     Exited (137) 13 minutes ago             namenode
# a8857dcda04d   fjardim/jupyter-spark    "/opt/docker/bin/ent…"   6 days ago     Exited (137) 13 minutes ago             jupyter-spark
# 00f5c92f680a   fjardim/zookeeper        "/bin/sh -c '/usr/sb…"   6 days ago     Exited (137) 13 minutes ago             zookeeper
# 9e74c86bbd8e   postgres                 "docker-entrypoint.s…"   3 months ago   Exited (0) 14 minutes ago               postgresql_db_1

docker stop $(docker ps -a -q)

docker start $(docker ps -a -q)

# docker start 12afb3fffd8d 3123eb553599 5cd57c1fa777

docker ps
