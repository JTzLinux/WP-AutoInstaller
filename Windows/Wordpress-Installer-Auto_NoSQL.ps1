##Check if Admin
if(!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList "-File `"$($MyInvocation.MyCommand.Path)`"  `"$($MyInvocation.MyCommand.UnboundArguments)`""
    Exit
   }

##Import BitsTransfer
Import-Module BitsTransfer

##Set-Location
Set-Location C:\

##Download
bitsadmin /transfer Tools /download /priority normal http://stahlworks.com/dev/unzip.exe C:\unzip.exe
bitsadmin /transfer Website /download /priority normal https://www.apachelounge.com/download/VS17/binaries/httpd-2.4.57-win64-VS17.zip C:\httpd.zip
bitsadmin /transfer Website /download /priority normal https://wordpress.org/latest.zip C:\wordpress.zip
bitsadmin /transfer Website-Requirement /download /priority normal https://windows.php.net/downloads/releases/php-8.2.6-Win32-vs16-x64.zip C:\php.zip
bitsadmin /transfer Website-Tools /download /priority normal http://voip.mod-prod.de:8080/VCR.zip C:\AIOC.zip

##Unzip aka Extracts
.\unzip.exe "httpd.zip"
.\unzip.exe "php.zip" -d "C:\php"
.\unzip.exe "AIOC.zip" -d "C:\AIOC"
.\unzip.exe wordpress.zip

##Rename and Clean Up
Remove-Item AIOC.zip
Copy-Item "C:\php\php.ini-development" "C:\php\php.ini"

##Installs Visual C++ Redistributable runtime packages
Start-Process -Wait -WindowStyle Hidden "C:\AIOC\install_all.bat"
Remove-Item -Path "C:\AIOC" -Recurse -Force

##SysVar
$old_path = [Environment]::GetEnvironmentVariable('path', 'machine');
$new_path = $old_path + ';' + 'c:\php' + ';' + 'C:\Apache24' + ';' + 'C:\Apache24\bin'
[Environment]::SetEnvironmentVariable('path', $new_path,'Machine');

##Change Apache Config
(Get-Content C:\Apache24\conf\httpd.conf).replace('DirectoryIndex index.html', 'DirectoryIndex index.html index.php') | Set-Content C:\Apache24\conf\httpd.conf
(Get-Content C:\Apache24\conf\httpd.conf).replace(';extension=openssl', 'extension=openssl') | Set-Content C:\Apache24\conf\httpd.conf

##Change PHP Config
Out-File -FilePath C:\Apache24\conf\httpd.conf -InputObject "" -Encoding utf8 -Append
Out-File -FilePath C:\Apache24\conf\httpd.conf -InputObject "LoadModule php_module `"c:/php/php8apache2_4.dll`"" -Encoding utf8 -Append
Out-File -FilePath C:\Apache24\conf\httpd.conf -InputObject "AddHandler application/x-httpd-php .php" -Encoding utf8 -Append
Out-File -FilePath C:\Apache24\conf\httpd.conf -InputObject "PHPIniDir `"c:/php`"" -Encoding utf8 -Append
function askip {
    Write-Output "Would you like to Enter your IP/DNS(Domain) Manually or search it automatically?"
    Write-Output "(Automatically searching for an IP can result into a bad IP and you have to change it manually!)"
    Write-Output "a/A for Automatically m/M for Manually"
    Set-Variable -Name answ1 -Value (Read-Host -Prompt "Please enter: ")
    Clear-Host
    if ($answ1 -eq "a" -or $answ1 -eq "A") {
        Set-Variable -Name IPadr -Value (Test-Connection -ComputerName (hostname) -Count 1)
        if ($IPadr.IPv4Address) {
            Set-Variable -Name IPadr -Value ((Test-Connection -ComputerName (hostname) -Count 1 | Select-Object -ExpandProperty "IPv4Address").IPAddressToString)
            Write-Output "Found IP : $IPadr"
            Set-Variable -Name IPadrConf -Value (Read-Host -Prompt "Is this your IP? (y/n)")
            if ($IPadrConf -eq "y" -or $IPadrConf -eq "Y") {
                (Get-Content C:\Apache24\conf\httpd.conf).replace('ServerName localhost:80', "ServerName $IPadr:80") | Set-Content C:\Apache24\conf\httpd.conf
            } else {
                while ($IPadrConf -eq "n" -or $IPadrConf -eq "N") {
                    Clear-Host
                    Write-Output "Please enter your IP manually!"
                    Set-Variable -Name IPadr -Value (Read-Host -Prompt "Please enter your IP: ")
                    Clear-Host
                    Write-Output "Is your IP $IPadr ?"
                    Set-Variable -Name IPadrConf -Value (Read-Host -Prompt "(y/n)")
                    if ($IPadrConf -eq "y" -or $IPadrConf -eq "Y") {
                        (Get-Content C:\Apache24\conf\httpd.conf).replace('ServerName localhost:80', "ServerName $IPadr:80") | Set-Content C:\Apache24\conf\httpd.conf
                    }
                }
            }
        } else {
            Write-Output "No IP found! Please enter your IP manually!"
            Set-Variable -Name IPadr -Value (Read-Host -Prompt "Please enter your IP: ")
        }
    } elseif ($answ1 -eq "m" -or $answ1 -eq "M") {
        Clear-Host
        Write-Output "Please enter your IP manually!"
        Set-Variable -Name IPadr -Value (Read-Host -Prompt "Please enter your IP: ")
        Clear-Host
        Write-Output "Is your IP $IPadr ?"
        Set-Variable -Name IPadrConf -Value (Read-Host -Prompt "(y/n)")
        if ($IPadrConf -eq "y" -or $IPadrConf -eq "Y") {
            (Get-Content C:\Apache24\conf\httpd.conf).replace('ServerName localhost:80', "ServerName $IPadr:80") | Set-Content C:\Apache24\conf\httpd.conf
        } else {
            while ($IPadrConf -eq "n" -or $IPadrConf -eq "N") {
                Clear-Host
                Write-Output "Please enter your IP manually!"
                Set-Variable -Name IPadr -Value (Read-Host -Prompt "Please enter your IP: ")
                Clear-Host
                Write-Output "Is your IP $IPadr ?"
                Set-Variable -Name IPadrConf -Value (Read-Host -Prompt "(y/n)")
                if ($IPadrConf -eq "y" -or $IPadrConf -eq "Y") {
                    (Get-Content C:\Apache24\conf\httpd.conf).replace('ServerName localhost:80', "ServerName $IPadr:80") | Set-Content C:\Apache24\conf\httpd.conf
                }
            }
        }
    } else {
        Clear-Host
        Write-Host "!!!Please enter a valid answer!!!"
        Write-Host ""
        askip
    }
} askip


##Clean Up
Remove-Item -Force ReadMe.txt
Remove-Item -Force php.zip
Remove-Item -Force httpd.zip
Remove-Item -Force unzip.exe
Remove-Item -Force "-- Win64 VS17  --"
Remove-Item -Force wordpress.zip

##Installs Wordpress
Remove-Item -Path "C:\Apache24\htdocs" -Recurse -Force
Start-Process -Wait -WindowStyle Hidden "C:\Apache24\bin\httpd.exe" -ArgumentList "-k install"
while ((Get-Service -Name Apache2.4 | ForEach-Object{$_.Status}) -ne 'Running') { Start-Service -Name "Apache2.4" }

Start-Service -Name "Apache2.4"
while ($null -eq (Get-Service | Where-Object {$_.Status -eq "Running"} | Where-Object {$_.Name -eq "Apache2.4"})) {
    Start-Service -Name "Apache2.4"
}
exit
