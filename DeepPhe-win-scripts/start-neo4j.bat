@echo off
REM 2022-10-22;JDL - Setting JAVA_HOME is necessary, otherwise an incompatible JAVA_HOME might be used
set JAVA_HOME=_java_home_dir
title DpheNeo4jServer

SETLOCAL

Powershell -NoProfile -NonInteractive -NoLogo -ExecutionPolicy Bypass -File "%~dp0neo4j.ps1" %*
EXIT /B %ERRORLEVEL%
