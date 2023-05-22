@echo off 
setlocal enableextensions disabledelayedexpansion

set "search=DirectoryIndex index.html"
set "replace=DirectoryIndex index.html index.php"

set "textFile=C:\Apache24\conf\httpd.conf"

for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
    set "line=%%i"
    setlocal enabledelayedexpansion
    >>"%textFile%" echo(!line:%search%=%replace%!
    endlocal
)
::echo del C:\set1.bat >> C:/dell.bat
::echo del C:\dell.bat >> C:/dell.bat
::echo exit >> C:/dell.bat
::echo timeout 1 >> C:/dell.bat
::start call C:/dell.bat
exit
