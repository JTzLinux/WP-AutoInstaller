setlocal
set $source=C:\php\php.ini
set $Dest=C:\php\php.ini

set "search=;extension=mysqli"
set "replace=extension=mysqli"

for /f "delims=" %%a in ('powershell -c "(get-content '%$source%') | foreach-object {$_ -replace '%Search%', '%replace%'} | set-content '%$dest%'"') do echo %%a
set "search=;extension=openssl"
set "replace=extension=openssl"

for /f "delims=" %%a in ('powershell -c "(get-content '%$source%') | foreach-object {$_ -replace '%Search%', '%replace%'} | set-content '%$dest%'"') do echo %%a
exit