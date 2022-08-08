@ECHO OFF
TITLE DeepPhe-Viz Update and Run, Ctrl-C to Close

echo ===========
echo DeepPhe-Viz
echo ===========
echo.
echo This script updates required external applications and starts the DeepPhe Visualizer.
echo The DeepPhe Visualizer interacts with the Neo4j Server installed with DeepPhe.
echo If you have not started the Neo4j Server please do so now.
echo.
echo After the external applications have been updated DeepPhe-Viz will start.
echo A second process will be launched, labeled "npm start".
echo When you are done with DeepPhe-Viz, open the "npm start" window and type Ctrl-C to close it.
echo.
echo You must also type Ctrl-C to close this window.

FOR /F "tokens=5 delims= " %%P IN ('netstat -a -n -o ^| findstr ":3000.*LISTENING 3001.*LISTENING"') DO taskkill /F /PID %%P

:: Turn off logging except for errors. This may be a bad idea.  The default value is "notice".  The _progress option controls progress bars.
set npm_config_loglevel=error

:: Set nodejs to run in production mode only.  That should decrease installed dependencies.
SET NODE_ENV=production

::npm config

set PORT=3001

::Consider using a check on installation having already been performed and if not use PAUSE command.

ECHO.
ECHO Updating the DeepPhe-Viz to Neo4j Connection External Application Components.
ECHO Some components may take a long time to update.  Please be patient.
ECHO.
ECHO If this is your first time running DeepPhe-Viz, it may appear as if the update is stalling.
ECHO Please be patient as it will resume.
ECHO.
PAUSE
ECHO.
cd api
call npm install --force
::call npm install

cls
echo %ERRORLEVEL%

ECHO.
ECHO Updating the DeepPhe-Viz Client External Application Components.
ECHO.
ECHO If this is your first time running DeepPhe-Viz, it may appear as if the update is stalling.
ECHO Please be patient as it will resume.
ECHO Some components may take a long time to update.  Please be patient.
ECHO.
cd ../client
call npm install --force

:: Consider using dos start /b (no new window) with npm log_level silent or logging redirected to a file.
ECHO.
ECHO Starting the DeepPhe-Viz to Neo4j Connection ...
ECHO.
cd ../api
start "DeepPhe-Viz to Neo4j Connection, Ctrl-C to Close" /min cmd /c npm start

ECHO.
ECHO Starting the DeepPhe-Viz Client ...
ECHO.

cd ../client
set PORT=3000
TITLE "DeepPhe-Viz Client"
npm start

EXIT
