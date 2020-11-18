 ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄ 
▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌
▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀ 
▐░▌       ▐░▌▐░▌       ▐░▌▐░▌          
▐░█▄▄▄▄▄▄▄█░▌▐░▌   ▄   ▐░▌▐░█▄▄▄▄▄▄▄▄▄ 
▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌
▐░█▀▀▀▀▀▀▀█░▌▐░▌ ▐░▌░▌ ▐░▌ ▀▀▀▀▀▀▀▀▀█░▌
▐░▌       ▐░▌▐░▌▐░▌ ▐░▌▐░▌          ▐░▌
▐░▌       ▐░▌▐░▌░▌   ▐░▐░▌ ▄▄▄▄▄▄▄▄▄█░▌
▐░▌       ▐░▌▐░░▌     ▐░░▌▐░░░░░░░░░░░▌
 ▀         ▀  ▀▀       ▀▀  ▀▀▀▀▀▀▀▀▀▀▀ 


This script will install the following packages: 

- Web Server: Apache2 and modues required
- Hypertext Preprocessor: PHP v7.4  and modues required
- Database engine: MySQL v5.7 and modues required


[ Please Y to continue or N to cancel or  press C for customized setup ]
>>> Please enter an option:  Y
Initializing script... Please wait.
Task ======> System Update 
Task ======> Install software-properties-common 
Task ======> Adding repository 
Task ======> Installing Apache Web Server and modules 
Task ======>  Check for previons Apache installation 

Not found a previous verion of Apache Web Server installed. Continue with the installation.
Task ======> Installing Apache binaries and modules 
Task ======> Installing PHP v7.4 and modules 
Task ======> Checking previons version of PHP 

Not found a previous verion of PHP installed. Continue with the installation.
Task ======> Installing PHP binaries and modules 
Task ======> Creating firewall rule to allow traffic for http port (80/tcp)
Task ======> Creating firewall rule to allow traffic for https port (443/tcp) 
Task ======> Adding certbot (Let's Encrypt) repository 
Task ======> Instaling certbot (Let's Encrypt) package 
Task ======> System Update 
Task ======> Checking Apache web server installation process 

The script installed the Apache2 and PHP packages.

Do you want to run a test to check if the installation was successful.

[ Please Y to test or N to finish the script  ]
>>> Enter an option:  Y

Creating a php test file...
Please follow next steps
1. Copy the following web address: http://X.X.X.X/index.php
2. Open a new tab in your prefered web browser (Firefox or Chrome)
3. Paste the web address and press enter
[ NOTE: PHP Info page should be displayed]
Did you was able to see the phpinfo page? Y


The evaluation of Apache Web Server + PHP was successfull.
[NOTE:] PHP Info test page was deleted for security best practices.
Congratulations this script was completed succesfully!
