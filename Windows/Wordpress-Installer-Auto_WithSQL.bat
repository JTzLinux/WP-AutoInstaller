if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
cd C:\
bitsadmin /transfer Tools /download /priority normal http://stahlworks.com/dev/unzip.exe C:\unzip.exe
bitsadmin /transfer SQL /download /priority normal https://mirror.creoline.net/mariadb//mariadb-10.11.3/winx64-packages/mariadb-10.11.3-winx64.zip C:\SQL.zip
bitsadmin /transfer Website /download /priority normal https://www.apachelounge.com/download/VS17/binaries/httpd-2.4.57-win64-VS17.zip C:\httpd.zip
bitsadmin /transfer Website /download /priority normal https://wordpress.org/latest.zip C:\wordpress.zip
bitsadmin /transfer Website-Requirement /download /priority normal https://windows.php.net/downloads/releases/php-8.2.6-Win32-vs16-x64.zip C:\php.zip
bitsadmin /transfer Website-Tools /download /priority normal https://modernrp.de/wp-content/VCR.zip C:\AIOC.zip
bitsadmin /transfer Website-Parameters /download /priority normal https://modernrp.de/wp-content/var.ps1 C:\var.ps1
bitsadmin /transfer Website-Parameters /download /priority normal https://modernrp.de/wp-content/set1.bat C:\set1.bat
bitsadmin /transfer Website-Parameters /download /priority normal https://modernrp.de/wp-content/set2.bat C:\set2.bat
bitsadmin /transfer Website-Parameters /download /priority normal https://modernrp.de/wp-content/set3.bat C:\set3.bat
unzip "httpd.zip"
unzip "php.zip" -d "C:\php"
unzip "AIOC.zip" -d "C:\AIOC"
unzip wordpress.zip
unzip SQL.zip
move mariadb-10.11.3-winx64 mysql
del SQL.zip
del AIOC.zip
start /wait call "C:\AIOC\install_all.bat"
rmdir /S /Q C:\AIOC
start /wait call "C:\set1.bat"
start /wait call "C:\set2.bat"
del "-- Win64 VS17  --"
del ReadMe.txt
del php.zip
del httpd.zip
del unzip.exe
Powershell.exe -executionpolicy bypass -File C:\var.ps1
del var.ps1
del set1.bat
del set2.bat
del wordpress.zip
copy "C:\php\php.ini-development" "C:\php\php.ini" /a
start /wait call "C:\set3.bat"
del set3.bat
echo LoadModule php_module "c:/php/php8apache2_4.dll" >> C:\Apache24\conf\httpd.conf
echo AddHandler application/x-httpd-php .php >> C:\Apache24\conf\httpd.conf
echo PHPIniDir "c:/php" >> C:\Apache24\conf\httpd.conf
rmdir /S /Q C:\Apache24\htdocs
move wordpress C:\Apache24\htdocs
start c:\Apache24\bin\httpd.exe -k install
sc start Apache2.4
Endlocal
@echo off
rem 16 stings pwd

setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION
set alfanum=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789

set pwd=
FOR /L %%b IN (0, 1, 16) DO (
    SET /A rnd_num=!RANDOM! * 62 / 32768 + 1
    for /F %%c in ('echo %%alfanum:~!rnd_num!^,1%%') do set "pwd2=!pwd2!%%c"
)
set pwd=
FOR /L %%b IN (0, 1, 16) DO (
    SET /A rnd_num=!RANDOM! * 62 / 32768 + 1
    for /F %%c in ('echo %%alfanum:~!rnd_num!^,1%%') do set "pwd=!pwd!%%c"
)

Endlocal & set "pwd=%pwd%" & set "pwd2=%pwd2%"
Set /a _rand=(%RANDOM%*500/32768)+1 
Set /a _randuser=(%RANDOM%*500/32768)+1 
set database=wordpress_%_rand%_db
set user=wordpress-%_randuser%
set userpassword=%pwd%
set rootpassword=%pwd2%
echo.Your Database name is: %database% >> C:%HOMEPATH%/Desktop/Login.txt
echo.Your username is: %user% >> C:%HOMEPATH%/Desktop/Login.txt
echo.Your userpassword is: %userpassword% >> C:%HOMEPATH%/Desktop/Login.txt
echo.Your rootpassword is: %rootpassword% >> C:%HOMEPATH%/Desktop/Login.txt
cd C:\mysql\bin
start /wait call "mysql_install_db.exe" --service=MySQL
sc start MySQL
::start call "mysqld.exe"
mysql.exe -u root -e "CREATE DATABASE %database%;"
mysql.exe -u root -e "grant all privileges on %database%.* TO '%user%'@'localhost' identified by '%userpassword%';"
mysql.exe -u root -e "FLUSH PRIVILEGES;"
mysql.exe -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '%rootpassword%';"
mklink "C:%HOMEPATH%/Desktop/StartSQLServer" "C:\mysql\bin\mysqld.exe"
set "userpassword="
set "rootpassword="
set "user="
set "database="
set "pwd="
set "pwd2="
set "rand="
set "randuser="
set "alfanum="
