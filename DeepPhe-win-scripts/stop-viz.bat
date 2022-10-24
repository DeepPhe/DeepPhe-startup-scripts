@echo off
title StopViz
wmic Path win32_process Where "CommandLine Like '%dphe-viz-launcher-1.0-jar-with-dependencies.jar%'" Call Terminate
