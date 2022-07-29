#!/usr/bin/env bash

neo4jpid=$(lsof -i tcp:7687  -F T -Ts | grep -i "TST=LISTEN" -B1 | head -n1)
export JAVA_HOME=/Applications/DeepPhe/.install4j/jre.bundle/Contents/Home
BASEDIR=$(dirname $0)
echo "Script location: ${BASEDIR}"

#if neo4j isn't running, run it
if [ -z "${neo4jpid}" ]; then
  echo "Starting Neo4j..."
  (cd ${BASEDIR}/neo4j-community-3.5.12/bin && ./neo4j console)
else
  echo "Neo4j is already running!"
fi
