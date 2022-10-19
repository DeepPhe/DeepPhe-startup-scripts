#!/bin/bash
sh -c 'echo $$ > viz.pid; exec java -jar dphe-viz-launcher-1.0-jar-with-dependencies.jar viz.cfg'
