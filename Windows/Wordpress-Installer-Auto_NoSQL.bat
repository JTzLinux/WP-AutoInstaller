if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)
cd C:\
wget http://stahlworks.com/dev/unzip.exe
bitsadmin /transfer Website /download /priority normal https://www.apachelounge.com/download/VS17/binaries/httpd-2.4.57-win64-VS17.zip C:\httpd.zip
bitsadmin /transfer Website /download /priority normal https://wordpress.org/latest.zip C:\wordpress.zip
bitsadmin /transfer Website-Requirement /download /priority normal https://windows.php.net/downloads/releases/php-8.2.6-Win32-vs16-x64.zip C:\php.zip
bitsadmin /transfer Website-Tools /download /priority normal https://de1-dl.techpowerup.com/files/bEroV_imLs6v5RAKe3XO9w/1684545590/Visual-C-Runtimes-All-in-One-May-2023.zip C:\AIOC.zip
bitsadmin /transfer Website-Parameters /download /priority normal https://modernrp.de/wp-content/var.ps1 C:\var.ps1
bitsadmin /transfer Website-Parameters /download /priority normal https://modernrp.de/wp-content/set1.bat C:\set1.bat
bitsadmin /transfer Website-Parameters /download /priority normal https://modernrp.de/wp-content/set2.bat C:\set2.bat
bitsadmin /transfer Website-Parameters /download /priority normal https://modernrp.de/wp-content/set3.bat C:\set3.bat
unzip "httpd.zip"
unzip "php.zip" -d "C:\php"
unzip "AIOC.zip" -d "C:\AIOC"
unzip wordpress.zip
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
timeout 500
copy "C:\php\php.ini-development" "C:\php\php.ini" /a
start /wait call "C:\set3.bat"
del set3.bat
echo LoadModule php_module "c:/php/php8apache2_4.dll" >> C:\Apache24\conf\httpd.conf
echo AddHandler application/x-httpd-php .php >> C:\Apache24\conf\httpd.conf
echo PHPIniDir "c:/php" >> C:\Apache24\conf\httpd.conf
rmdir /S /Q C:\Apache24\htdocs
move wordpress C:\Apache24\htdocs
timeout 60
start c:\Apache24\bin\httpd.exe -k install
sc start Apache2.4