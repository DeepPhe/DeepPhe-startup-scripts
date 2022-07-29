TITLE DeepPhe-Viz Client/Server, Ctrl-C to Close

FOR /F "tokens=5 delims= " %%P IN ('netstat -a -n -o ^| findstr ":3000.*LISTENING 3001.*LISTENING"') DO taskkill /F /PID %%P

set npm_config_loglevel=silent npm version
set PORT=3001
cd api
call npm install --force
cd ../client
call npm install --force
cd ../api
start npm start
set PORT=3000
cd ../client
start npm start
