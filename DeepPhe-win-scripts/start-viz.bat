@ECHO OFF
TITLE DeepPhe-Viz Update and Run, Ctrl-C to Close

echo ===========
echo DeepPhe-Viz
echo ===========
echo.

FOR /F "tokens=5 delims= " %%P IN ('netstat -a -n -o ^| findstr ":3000.*LISTENING 3001.*LISTENING"') DO taskkill /F /PID %%P

if exist API_INSTALLED.TAG goto no_install_message

ECHO It looks like this is your first installation of the Viz Tool.
ECHO This script updates required external applications required by the DeepPhe Visualizer.
ECHO After this initial installation has been performed a reboot of Windows is required.
ECHO.
ECHO Some components may take a long time to update.  Please be patient.
ECHO Some component installations may appear to have stalled.  This is normal.
ECHO.

::Force a shutdown on Neo4j.  Not shutting down causes a corrupt transaction log e.g. neostore.transaction.db.32
::Do not do this.  taskkill does not gracefully shut down console apps, which means that the neo4j db will be corrupted.
::FOR /F "tokens=5 delims= " %%P IN ('netstat -a -n -o ^| findstr ":7687.*LISTENING"') DO taskkill /F /PID %%P
::Since we run the console Neo4j we cannot use a stop command.
::start "Stopping Neo4j" /d .. /min cmd /c stop-neo4j.bat

::cd api
::call npm cache clear --force
::cd ../client
::call npm cache clear --force
::cd ..

goto first_install_continue

:no_install_message

echo This script updates required external applications and starts the DeepPhe Visualizer.
echo The DeepPhe Visualizer interacts with the Neo4j Server installed with DeepPhe.
echo If you have not started the Neo4j Server please do so now.
echo.
echo After the external applications have been updated DeepPhe-Viz will start.
echo A second process will be launched, labeled "npm start".
echo When you are done with DeepPhe-Viz, open the "npm start" window and type Ctrl-C to close it.
echo.
echo You must also type Ctrl-C to close this window.

:first_install_continue

::npm configuration
set HOST=127.0.0.1
set PORT=3001
::Will this speed up the install???
call npm config set registry https://registry.npmjs.org/ --global

:: Turn off logging except for errors. This may be a bad idea.  The default value is "notice".  The _progress option controls progress bars.
set npm_config_loglevel=error

::Consider using a check on installation having already been performed and if not use PAUSE command.

ECHO.
ECHO Updating the DeepPhe-Viz to Neo4j Connection External Application Components.
if not exist API_INSTALLED.TAG ECHO Some components may take a long time to update.  Please be patient.
ECHO.
PAUSE
ECHO.
cd api
call npm install --force
cls
cd ..
echo %ERRORLEVEL%
echo ===========
echo DeepPhe-Viz
echo ===========
echo.


ECHO.
ECHO Updating the DeepPhe-Viz Client External Application Components.
ECHO Some components may take a long time to update.  Please be patient.
ECHO.
if not exist API_INSTALLED.TAG ECHO Some component installations may appear to have stalled.  This is normal.
ECHO.

cd client
call npm install --force
cls
cd ..


::See if this is the first run.  If so then there is a lengthy install.
if exist API_INSTALLED.TAG goto api_installed

ECHO.
ECHO It looks like this is your first installation of the Viz Tool.
ECHO A restart of your system is required before continuing.
ECHO.
ECHO Please close all other applications and return to this window when ready.
ECHO.
ECHO After rebooting you may restart Neo4j and the Viz Tool.
pause

echo api installed > API_INSTALLED.TAG
shutdown /r /t 3
exit


:api_installed

echo ===========
echo DeepPhe-Viz
echo ===========
echo.

:: Consider using dos start /b (no new window) with npm log_level silent or logging redirected to a file.
ECHO.
ECHO Starting the DeepPhe-Viz to Neo4j Connection ...
ECHO.
cd api

start "DeepPhe-Viz to Neo4j Connection, Ctrl-C to Close" cmd /c npm start

ECHO.
ECHO Starting the DeepPhe-Viz Client ...
ECHO.

cd ../client
set HOST=127.0.0.1
set PORT=3000
TITLE "DeepPhe-Viz Client"
npm start
