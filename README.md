# WP-AutoInstaller

This script is designed to make the installation process much easier for yourself because, let's face it, we all can be lazy sometimes ;)

## Note

I'm currently make an major change to make it more reliable that takes more time

I shall archive this rep until I got the time again to work on this script again updates will continue on in the future

## Disclaimer

This script is provided "as-is" without warranty of any kind, express or implied. Use at your own risk. The author is not responsible for any data loss, system damages, or issues that may arise from using this script. Always back up your data and test in a separate environment before deploying on a production system.

## IMPORTANT!

WordPress requires SQL installed! If you don't have a SQL installation, please use the SQL version of the scripts.

## Windows -  Without a SQL installation

If you already have SQL instaled and just want to install WordPress, simply use "Wordpress-Installer-Auto_NoSQL.bat". I always strive to keep this script up to date.

It is recommended to restart your PC, as the service might not start automatically. Alternatively, you can start it manually at "services.msc" (rebooting is still the easier option).

>If the script is outdated, feel free to contact me ^-^ at: [a.tara@modernrp.de](mailto:a.tara@modernrp.de) or [a.tara95@yahoo.com](mailto:a.tara95@yahoo.com) or create a issue

## Windows - With a SQL installation 
Preview: [![Preview of SQL](https://img.youtube.com/vi/xGu1ZyKtlS0/0.jpg)](https://www.youtube.com/watch?v=xGu1ZyKtlS0)

## Important Notes

- This script is designed for use on Windows systems.
- Running the script with elevated privileges is required.
- The script only supports 64-bit PC's running Windows.
- The script will generate random passwords for the database user and MariaDB root user, which are saved in a text file on your desktop called `Login.txt`. **DO NOT LOSE THIS FILE**, as it contains the only record of your generated passwords. If desired, change these passwords after running the script.


## Installation
Currently, passwords cannot be set using this script. However, I will explain how you can set them later.

If you don't have a SQL installation, use "Wordpress-Installer-Auto_WithSQL.bat". After running it, the script will handle everything *(mostly)* on its own. Once the script is finished, you should find a file called "Login.txt" on your desktop. You will need this file for logging in and accessing the WordPress page.

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

If you want to make changes, you can use your SQL database management software (such as HeidiSQL). Login using the IP of the server (or "localhost" if you run your SQL installation on the same device) and use the root password provided in the Login.txt file. This will grant you access to the database. However, it is not necessary, as WordPress handles it for you ;)

It is recommended to restart your PC, as the service might not start automatically. Alternatively, you can start it manually at "services.msc" (rebooting is still the easier option).

## Uninstallation

Before doing any steps don't forget to stop the services with services.msc

To remove the installed software and any created files (except the `Login.txt` on your desktop), simply delete the following folders:
- `C:\Apache24`
- `C:\mysql`
- `C:\php` 

And remove the Systemvariable:
- c:\php
- C:\Apache24
- C:\Apache24\bin

>If the script is outdated, feel free to contact me ^-^ at: [a.tara@modernrp.de](mailto:a.tara@modernrp.de) or [a.tara95@yahoo.com](mailto:a.tara95@yahoo.com) or create a issue

## Linux?

Yes, there will be a Linux version. I am currently working on it.

## MacOS?

Maybe I will consider it, but since hosting a server on MacOS is not very common (or at least I haven't heard much about it), it will have a lower priority. Sorry!

# Final Words

Thank you to everyone using my script! It makes me happy to see people finding value in this kind of tool!

If you'd like, you can show your support by donating to me via PayPal:

[![paypal](https://raw.githubusercontent.com/stefan-niedermann/paypal-donate-button/master/paypal-donate-button.png)](https://www.paypal.com/donate/?hosted_button_id=BU4LRWHL9RN5E)


# Credits

Thank you [u/Gohan472](https://www.reddit.com/user/Gohan472/) for helping and suggesting me some fixes for errors in my poor grammar

Thanks to you too [jamesisacutedog](https://github.com/jamesisacutedog) for fixing the grammar errors too
