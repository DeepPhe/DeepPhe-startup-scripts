@ECHO OFF
TITLE StartViz
REM _installer_java_home_dir
for /f "tokens=1,3" %%A in ('type viz.cfg') do call :SetParam %%A %%B
goto :StartVizServer

:StartVizServer

if exist serverexelist.txt erase serverexelist.txt
set serving=0
wmic process where caption="%SERVER_COMMAND%" list > serverexelist.txt 2>ignore.txt
for /f %%i in ('type serverexelist.txt') do set serving=%%~zi
if %serving% gtr 0 goto :StartVizClient

echo Starting Visualization Tool Server ...
start /B "Viz Server" %SERVER_COMMAND%
ping 127.0.0.1 -n 5 >NUL

:StartVizClient

if exist clientexelist.txt erase clientexelist.txt
set clienting=0
wmic process where caption="%CLIENT_COMMAND%" list > clientexelist.txt 2>ignore.txt
for /f %%i in ('type clientexelist.txt') do set clienting=%%~zi
if %clienting% gtr 0 goto :LaunchWebPage

echo Starting Visualization Tool Client ...
start /B "Viz Client" %CLIENT_COMMAND%
ping 127.0.0.1 -n 5 >NUL

:LaunchWebPage

echo Launching Visualization Tool Web Page ...
REM start /max http://127.0.0.1:3000
start /max %APP_URL%:%APP_PORT%

goto :eof

:SetParam
set envname=%1
set rawvalue=%2
set envvalue=%rawvalue:"=%
set %envname%=%envvalue%
