# WP-AutoInstaller

This script is designed to make the installation process much easier for yourself because, let's face it, we can be lazy sometimes ;)

## IMPORTANT!

WordPress requires SQL! If you don't have SQL, please use the SQL version of the scripts.

## Windows - Without SQL

If you already have SQL and just want to install WordPress, simply use "Wordpress-Installer-Auto_NoSQL.bat". I always strive to keep this script up to date.

It is recommended to restart your PC, as the service might not start automatically. Alternatively, you can start it manually at "services.msc" (rebooting is still the easier option).

>If the script is outdated, feel free to contact me ^-^ at: [a.tara@modernrp.de](mailto:a.tara@modernrp.de) or [a.tara95@yahoo.com](mailto:a.tara95@yahoo.com)

## Windows - With SQL
Preview: [![Preview of SQL](https://img.youtube.com/vi/xGu1ZyKtlS0/0.jpg)](https://www.youtube.com/watch?v=xGu1ZyKtlS0)

Currently, passwords cannot be set using this script. However, I will explain how you can set them later.

If you don't have SQL, use "Wordpress-Installer-Auto_WithSQL.bat". After running it, the script will handle everything *(mostly)* on its own. Once the script is finished, you should find a file called "Login.txt" on your desktop. You will need this file for logging in and accessing the WordPress page.

After running and completing the script, go to "localhost" (if you installed it locally on your computer) or enter the server URL in your browser. Once connected to your website, choose your language and enter the information of the SQL server (from Login.txt).

Use the following information:
```diff
-!!!DO NOT DELETE THE LOGIN.TXT AND KEEP IT IN A SAFE PLACE!!!
-!!!NEVER ENTER ROOT AND ROOTPASSWORD IN THERE!!!
```
```
Database Name = Database
Username = username
Password = userpassword
You can leave the rest as is.
```
```diff
-!!!NEVER ENTER ROOT AND ROOTPASSWORD IN THERE!!!
```

If you want to make changes, you can use your SQL software (such as HeidiSQL). Login using the IP of the server (or "localhost" if you run your SQL software on the same device) and use the root password provided in the Login.txt file. This will grant you access to the database. However, it is not necessary, as WordPress handles it for you ;)

It is recommended to restart your PC, as the service might not start automatically. Alternatively, you can start it manually at "services.msc" (rebooting is still the easier option).

>If the script is outdated, feel free to contact me ^-^ at: [a.tara@modernrp.de](mailto:a.tara@modernrp.de) or [a.tara95@yahoo.com](mailto:a.tara95@yahoo.com)

## Linux?

Yes, there will be a Linux version. I am currently working on it.

## MacOS?

Maybe I will consider it, but since hosting a server on MacOS is not very common (or at least I haven't heard much about it), it will have a lower priority. Sorry!

# Final Words

Thank you to everyone using my script! It makes me happy to see people finding value in this kind of tool!

If you'd like, you can show your support by donating to me via PayPal:

![paypal](https://raw.githubusercontent.com/stefan-niedermann/paypal-donate-button/master/paypal-donate-button.png)
