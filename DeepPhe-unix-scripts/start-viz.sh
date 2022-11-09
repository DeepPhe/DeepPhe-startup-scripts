#!/bin/bash
export JAVA_HOME=_installer_java_home_dir
sh -c 'echo $$ > viz.pid; exec java -jar dphe-viz-launcher-1.0-jar-with-dependencies.jar viz.cfg'
sleep 5
open http://localhost:3000
