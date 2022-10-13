@echo off
title StopViz

wmic process where caption="cmd.exe" get commandline,processid > cmdexelist.txt

for /f "tokens=*" %%P in ('type cmdexelist.txt') do call :CheckStart %%P
goto :eof

:CheckStart
set rawline=%*
set line=%rawline:"=%
if not "x%line:DeepPhe-Viz=%"=="x%line%" call :DoKill %line%
if not "x%line:./bin/www=%"=="x%line%" call :DoKill %line%
goto :eof

:DoKill
set killer=%*
for %%W in (%killer%) do set last=%%W
taskkill /f /t /pid %last%
goto :eof
