title Neo4j Server, Ctrl-C to Close
SET "JAVA_HOME=NEO4J_JAVA_VAR"
SET "PATH=NEO4J_JAVA_VAR\bin;%PATH%"

@echo off
echo Starting the Neo4j Server...
echo.
echo To stop the server, click inside this window and press Control-C.

cd neo4j-community-3.5.12\bin
neo4j.bat console