@echo off
title StopViz
taskkill /im DeepPheVizClient.exe /f
taskkill /im DeepPheVizApi.exe /f
