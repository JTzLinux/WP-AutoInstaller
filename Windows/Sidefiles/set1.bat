@echo off
echo "Would you like to Enter your IP/DNS(Domain) Manually or search it automatically?"
echo "(Automatically searching for an IP can result into a bad IP and you have to change it manually!)"
echo "a/A for Automatically m/M for Manually"
set /p "answ1=Please enter: "
echo %answ1%
if %answ1% == M goto :Man
if %answ1% == m goto :Man
if %answ1% == A goto :Auto
if %answ1% == a goto :Auto
goto :Error
pause

:Auto
cls
for /f "tokens=1-2 delims=:" %%a in ('ipconfig^|find "IPv4"') do set ip=%%b
set input=%ip:~1%
echo %input%
echo "Is this IP right?"
set /p "answ2=[Y]es / [N]o: " 
if %answ2% == n goto :Man
if %answ2% == N goto :Man
goto :End

:Man
cls
set /p "input=Please enter your IP/DNS/Domainname: "
goto :End
:Error
set input="localhost"
goto :End
:End
echo %input%
setlocal
set $source=C:\php\php.ini
set $Dest=C:\php\php.ini
set "search=#ServerName www.example.com:80"
set "replace=ServerName www.%input%.com:80"

for /f "delims=" %%a in ('powershell -c "(get-content '%$source%') | foreach-object {$_ -replace '%Search%', '%replace%'} | set-content '%$dest%'"') do echo %%a
exit
pause