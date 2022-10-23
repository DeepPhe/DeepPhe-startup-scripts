@ECHO OFF
TITLE StartViz
"_installer_java_home_dir\bin\java" -jar "%~dp0dphe-viz-launcher-1.0-jar-with-dependencies.jar" viz.cfg
start /max http://127.0.0.1:3000
