@ECHO OFF
TITLE StartViz
REM @setlocal enableextensions enabledelayedexpansion

:: Check to see if node the viz tool has already been started
wmic process where caption="node.exe" get commandline > nodelist.txt

for /f "tokens=*" %%P in ('type nodelist.txt') do call :CheckStart %%P

if exist API_INSTALLED.TAG goto no_install_message

ECHO It looks like this is your first installation of the Viz Tool.
ECHO This script updates required external applications required by the DeepPhe Visualizer.

ECHO Some components may take a long time to update.  Please be patient.
ECHO Some component installations may appear to have stalled.  This is normal.

::cd api
::call npm cache clear --force
::cd ../client
::call npm cache clear --force
::cd ..

goto first_install_continue

:no_install_message

echo This script updates required external applications and starts the DeepPhe Visualizer.
echo After the external applications have been updated DeepPhe-Viz will start.


:first_install_continue

::npm configuration
set HOST=127.0.0.1
set PORT=3001
::Will this speed up the install???
call npm config set registry https://registry.npmjs.org/ --global

:: Turn off logging except for errors. This may be a bad idea.  The default value is "notice".  The _progress option controls progress bars.
set npm_config_loglevel=error

::Consider using a check on installation having already been performed and if not use PAUSE command.

ECHO Updating the DeepPhe-Viz to Neo4j Connection External Application Components.
if not exist API_INSTALLED.TAG ECHO Some components may take a long time to update.  Please be patient.

cd api
call npm install --force
cd ..


ECHO Updating the DeepPhe-Viz Client External Application Components.
ECHO Some components may take a long time to update.  Please be patient.

if not exist API_INSTALLED.TAG ECHO Some component installations may appear to have stalled.  This is normal.

cd client
call npm install --force
cd ..

::See if this is the first run.  If so then there is a lengthy install.
if exist API_INSTALLED.TAG goto api_installed

ECHO It looks like this is your first installation of the Viz Tool.
::ECHO A restart of your system is required before continuing.
::ECHO Please close all other applications and return to this window when ready.
::ECHO After rebooting you may restart Neo4j and the Viz Tool.

echo api installed > API_INSTALLED.TAG
::shutdown /r /t 3
::exit

:api_installed
ECHO Starting the DeepPhe-Viz to Neo4j Connection ...
cd api
start /b "VizNeo4j" npm start

ECHO Starting the DeepPhe-Viz Client ...
cd ../client
set HOST=127.0.0.1
set PORT=3000
start /b "VizClient" npm start

goto :DoneDoing

:CheckStart
set rawline=%*
set line=%rawline:"=%
if not "x%line:DeepPhe-Viz=%"=="x%line%" call :DoOpen
goto :eof

:DoOpen
echo The DeepPhe Visualizer Service is already running.  Opening web page ...
start /max http://127.0.0.1:3000/material-dashboard-react
goto :DoneDoing

:DoneDoing
exit
