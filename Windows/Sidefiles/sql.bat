mysql.exe -u root -e "CREATE DATABASE %1;"
mysql.exe -u root -e "GRANT ALL PRIVILEGES ON %1.* TO '%2'@'localhost' IDENTIFIED BY '%3';"
mysql.exe -u root -e "FLUSH PRIVILEGES;"
mysql.exe -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '%4';"