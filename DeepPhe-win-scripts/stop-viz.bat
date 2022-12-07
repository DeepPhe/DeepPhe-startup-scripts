@echo off
title StopViz

wmic process where caption="DeepPheVizApi.exe" get processid > cmdexelist.txt
wmic process where caption="DeepPheVizClient.exe" get processid >> cmdexelist.txt

for /f "tokens=*" %%P in ('type cmdexelist.txt') do call :DoKill %%P
goto :eof

:DoKill
set killer=%*
taskkill /f /t /pid %*
goto :eof
