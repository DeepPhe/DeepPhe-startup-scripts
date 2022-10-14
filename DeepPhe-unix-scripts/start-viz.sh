#!/bin/bash
sh -c 'cd .DeepPhe-Viz;echo $$ > viz.pid; exec java -jar dphe-viz-launcher-1.0-jar-with-dependencies.jar viz.cfg'
