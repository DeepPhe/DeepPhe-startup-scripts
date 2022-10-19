#!/bin/bash
pid=$(<viz.pid)
pkill 15 $pid
pkill -f DeepPheVizApi
pkill -f DeepPheVizClient
pkill -f dphe-viz-launcher-1.0-jar-with-dependencies
pkill -f start-viz.sh

rm viz.pid
