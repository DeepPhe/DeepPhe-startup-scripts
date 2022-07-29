#!/usr/bin/env bash
#!/usr/bin/env NODE_OPTIONS=--no-warnings node

clear

#kill existing services on port 3000 and 3001
lsof -t -i tcp:3000 | xargs kill
lsof -t -i tcp:3001 | xargs kill

neo4jpid=$(lsof -i tcp:7687  -F T -Ts | grep -i "TST=LISTEN" -B1 | head -n1)

BASEDIR=$(dirname $0)

#if neo4j isn't running, run it
if [ -z "${neo4jpid}" ]; then
  echo "Starting Neo4j..."
  (cd ${BASEDIR}/../neo4j-community-3.5.12/bin && ./neo4j console > ../neo4j.log 2>&1 &)
  sleep 3
fi

echo "Starting DeepPhe Webservice API..."

(export PORT=3001 && cd ${BASEDIR}/api && npm install &>/dev/null --force && npm start > ../webservice-api-run.log 2>&1 &)
rc=$?
if [ $rc -ne 0 ] ; then
  echo "Error: [$rc] when starting DeepPhe Webservice API, see ../webservice-api-run.log for details."
  exit $rc
else
  echo -e "    ...success!\n"
fi

#unset the HOST environment variable for local installations
unset HOST

echo "Installing DeepPhe Visualizer requirements..."
(cd ${BASEDIR}/client && npm install --force &>/dev/null)
echo -e "    ...requirements installed.\n"

echo "Starting DeepPhe Visualizer..."
echo -e "    Visualizer will open in your default web browser.\n\n(Press CTRL-C to terminate)"
(cd ${BASEDIR}/client  && npm start > ../visualizer-run.log 2>&1)

