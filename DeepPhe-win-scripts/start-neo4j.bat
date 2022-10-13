@echo off

title DpheNeo4jServer

SETLOCAL

Powershell -NoProfile -NonInteractive -NoLogo -ExecutionPolicy Bypass -File "%~dp0neo4j.ps1" %*
EXIT /B %ERRORLEVEL%
