@echo off
title Neo4j Server, Ctrl-C to Close

SET "JAVA_HOME=NEO4J_JAVA_VAR"
SET "PATH=NEO4J_JAVA_VAR\bin;%PATH%"
echo ========================
echo Neo4j Server for DeepPhe
echo ========================
echo .
echo This script starts the Neo4j Server that uses a custom plugin for DeepPhe.
echo .
echo Some error logs will be saved to file, but the majority of logging can be
echo viewed in this window.
echo .
echo The Neo4j server must be running during DeepPhe document processing 
echo and while running the DeepPhe Visualizer.
echo .
echo Startup is complete when you see a line indicating that a Remote interface is available.
echo .
echo To stop the server, click inside this window and press Control-C.
echo .
pause

cd neo4j-community-3.5.12\bin
neo4j.bat console
