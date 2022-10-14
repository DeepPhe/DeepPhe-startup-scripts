#!/bin/bash
pid=$(<viz.pid)
pkill 15 $pid
rm viz.pid
