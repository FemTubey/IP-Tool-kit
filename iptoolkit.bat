@echo off
:menu
cls
echo ====================================
echo      NETWORK TOOLKIT (2026)        
echo ====================================
echo 1) View Local IP
echo 2) Get Public IP
echo 3) Ping a Host
echo 4) Trace Route
echo 5) Port Scan (Common)
echo 6) DNS Lookup
echo 7) Exit
echo ====================================
set /p choice="Choose an option [1-7]: "

if %choice%==1 goto local
if %choice%==2 goto public
if %choice%==3 goto ping
if %choice%==4 goto trace
if %choice%==5 goto port
if %choice%==6 goto dns
if %choice%==7 exit
goto menu

:local
cls
ipconfig | findstr "IPv4"
pause
goto menu

:public
cls
curl -s https://ifconfig.me
echo.
pause
goto menu

:ping
cls
set /p target="Enter host: "
ping %target%
pause
goto menu

:trace
cls
set /p target="Enter host: "
tracert %target%
pause
goto menu

:port
cls
set /p target="Enter IP: "
powershell -Command "22,80,443,3389 | foreach { $t = New-Object System.Net.Sockets.TcpClient; $t.Connect('%target%', $_); if($t.Connected) { write-host 'Port ' $_ ' is OPEN' } $t.Close() } 2>$null"
pause
goto menu

:dns
cls
set /p domain="Enter domain: "
nslookup %domain%
pause
goto menu