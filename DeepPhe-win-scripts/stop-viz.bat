@echo off
title StopViz
taskkill /im DeepPheVizClient.exe /f
taskkill /im DeepPheClientApi.exe /f
