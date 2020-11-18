#!/bin/bash

#####################################################
# Author	: Ramon Resendiz (resendiz.me)
# Date		: Nov/12/2020
# Version 	: 0.1
# Description	: Script unattended that install Apache2 (SSL) +
# 		  PHP 7.4 + MySQL + LET’s ENCRYPT for Ubuntu 18.04
#		  running on EC2 instances / LightSail
#####################################################

# trap ctrl-c and call ctrl_c()
trap '' SIGINT

OUT=/tmp/install.sh
cat /dev/null > ./install.log
clear
echo " ▄▄▄▄▄▄▄▄▄▄▄  ▄         ▄  ▄▄▄▄▄▄▄▄▄▄▄  " 
echo "▐░░░░░░░░░░░▌▐░▌       ▐░▌▐░░░░░░░░░░░▌ "
echo "▐░█▀▀▀▀▀▀▀█░▌▐░▌       ▐░▌▐░█▀▀▀▀▀▀▀▀▀  "
echo "▐░▌       ▐░▌▐░▌       ▐░▌▐░▌           "
echo "▐░█▄▄▄▄▄▄▄█░▌▐░▌   ▄   ▐░▌▐░█▄▄▄▄▄▄▄▄▄  "
echo "▐░░░░░░░░░░░▌▐░▌  ▐░▌  ▐░▌▐░░░░░░░░░░░▌ "
echo "▐░█▀▀▀▀▀▀▀█░▌▐░▌ ▐░▌░▌ ▐░▌ ▀▀▀▀▀▀▀▀▀█░▌ "
echo "▐░▌       ▐░▌▐░▌▐░▌ ▐░▌▐░▌          ▐░▌ "
echo "▐░▌       ▐░▌▐░▌░▌   ▐░▐░▌ ▄▄▄▄▄▄▄▄▄█░▌ "
echo "▐░▌       ▐░▌▐░░▌     ▐░░▌▐░░░░░░░░░░░▌ "
echo " ▀         ▀  ▀▀       ▀▀  ▀▀▀▀▀▀▀▀▀▀▀  "
echo ""
echo "This script will install the following packages: "
echo "- Web Server: Apache2 and modues required"
echo "- Hypertext Preprocessor: PHP v7.4  and modues required"
echo "- Database engine: MySQL v5.7 and modues required"

while true; do
	echo -e "\n"
	echo -e "[ Please \e[96mY \e[0mto continue or \e[96mN \e[0mto cancel or  press \e[96mC \e[0mfor customized setup ]"
    read -p ">>> Please enter an option:  " ync
    case $ync in
        [Yy]* ) echo -e "\e[92mInitializing script... Please wait.\e[0m"; 
		# General update
		echo "Task ======> System Update " 
		echo "Task ======> System Update " >> install.log
		apt-get update --yes >> install.log	
		# install software-properties-common package
		echo "Task ======> Install software-properties-common "
		echo "Task ======> Install software-properties-common " >> install.log
		apt-get --yes install software-properties-common >>install.log
		# add repository to install the latest php version available
		echo "Task ======> Adding repository " 
		echo "Task ======> Adding repository " >>install.log
		add-apt-repository ppa:ondrej/php --yes >>install.log
		echo "Task ======> Installing Apache Web Server and modules "
		echo "Task ======> Installing Apache Web Server and modules " >> install.log
		# install apache2 and apache2 modules required
		# apache2 variable that cointains the list of the apache2 packages installed in the system
		apache2=`dpkg -l|grep apache2|awk -F" " '{ print $2 }'|head -n 1`
		echo "Task ======>  Check for previons Apache installation " 
		echo "Task ======>  Check for previons Apache installation " >> install.log
		# if condition that check if the variable $apache2 is empty or not
		if [ -z "$apache2" ]
		   then
			   echo -e "\nNot found a previous verion of Apache Web Server installed. Continue with the installation."
		   else
			echo -e "\nFound a previous version of Apache Web Server installed."
                        for removal in `dpkg -l|grep apache2|awk -F" " '{ print $2 }'`
                                do
					echo "Uninstalling: $removal"
                                        apt-get remove $removal --yes >> install.log 2>&1
                                        echo "Removing residual files: $removal"
                                        dpkg -P $removal >> install.log 2>&1
                                done
		fi
		apache2=""
		# 
		# installing apache 2 packages
		echo "Task ======> Installing Apache binaries and modules "
		echo "Task ======> Installing Apache binaries and modules " >> install.log
		apt-get install -y apache2 apache2-{bin,dev,data,ssl-dev,utils} >> install.log
		
		echo "Task ======> Installing PHP v7.4 and modules " 
		echo "Task ======> Installing PHP v7.4 and modules " >> install.log
                # install php 7.4 and php 7.4 modules required
                # php variable that cointains the list of the php packages installed in the system
		php=`dpkg -l|grep php|awk -F" " '{ print $2 }'|head -n 1`

                echo "Task ======> Checking previons version of PHP "
                echo "Task ======> Checking previons version of PHP " >> install.log
		# if condition that check if the variable $php is empty or not
                if [ -z "$php" ]
                   then
                           echo -e "\nNot found a previous verion of PHP installed. Continue with the installation."
                   else
                        echo -e "\nFound a previous version of PHP installed."
                        echo -e "Uninstalling previous version found."
                        for removal in `dpkg -l|grep php|awk -F" " '{ print $2 }'`
                                do
					echo "Uninstalling: $removal"
					apt-get remove $removal --yes >> install.log 2>&1
                                        echo "Removing residual files: $removal"
					dpkg -P $removal >> install.log 2>&1
                                done
                fi
                php=""
		# installing php  packages
                echo "Task ======> Installing PHP binaries and modules "
                echo "Task ======> Installing PHP binaries and modules " >> install.log
                apt-get install -y php7.4 php7.4-{bcmath,bz2,cli,common,curl,gd,http,intl,json,mbstring,mysql,propro,soap,raphf,zip,common} libapache2-mod-php7.4 >> install.log
		echo "Task ======> Creating firewall rule to allow traffic for http port (80/tcp)" 
		echo "Task ======> Creating firewall rule to allow traffic for http port (80/tcp)" >> install.log 
		# allow traffic for port 80/tcp (http)
		ufw allow 80/tcp >> install.log 2>&1
		echo "Task ======> Creating firewall rule to allow traffic for https port (443/tcp) " 
		echo "Task ======> Creating firewall rule to allow traffic for https port (443/tcp)" >> install.log 
		# allow traffic for port 443/tcp
		ufw allow 443/tcp >> install.log 2>&1
		echo "Task ======> Adding certbot (Let's Encrypt) repository " 
		echo "Task ======> Adding certbot (Let's Encrypt) repository " >> install.log
		# add respository for certbot (Let's Encrypt)
		add-apt-repository ppa:certbot/certbot --yes >> install.log
		# installing certbot (Let's Encrypt)
		echo "Task ======> Instaling certbot (Let's Encrypt) package " 
		echo "Task ======> Instaling certbot (Let's Encrypt) package " >> install.log
		apt-get  install python-certbot-apache --yes >> install.log
		# system update
		echo "Task ======> System Update "
                echo "Task ======> System Update " >> install.log
		apt-get update >> install.log
		# enabling apache2 to start with the system startup
		systemctl enable apache2 >> install.log 2>&1
		# checking Apache2 is up and running
		echo -e "Task ======> Checking Apache web server installation process \n"
		echo -e "Task ======> Checking Apache web server installation process \n">> install.log
		apache2=`service apache2 status|grep PID|awk -F":" '{ print $2 }'|awk -F" " '{ print $1 }'`
		if [ -z "$apache" ]
                    then
                        phpPackages=`dpkg -l|grep php|awk -F" " '{ print $2 }'|head -n 1`
                        apache2Packages=`dpkg -l|grep apache2|awk -F" " '{ print $2 }'|head -n 1`
                        if [ -z "$apache2Packages" ] && [ -z "$phpPackages" ]
                             then
                                echo -e "The script couldn't install the Apache2 and PHP packages.\n"
                                echo -e "Please check the install.log for more information.\n"
                                phpPackages=""
                                apache2Packages=""
                            else
                                echo -e "The script installed the Apache2 and PHP packages.\n"
				while true; do
                                	echo -e "Do you want to run a test to check if the installation was successful.\n"
        				echo -e "[ Please \e[96mY \e[0mto test or \e[96mN \e[0mto finish the script  ]"
    					read -p ">>> Enter an option:  " phpTestPage
					case $phpTestPage in
        				[Nn]* ) echo -e "\n\e[92mTest the web server as skipped.\e[0m"
						echo -e "\n\e[91mThe script has finished without testing.\e[0m"
						exit;;
        				[Yy]* ) echo -e "\n\e[92mCreating a php test file...\e[0m"
cat <<EOF >/var/www/html/index.php
<?php
phpinfo();
?>
EOF
					EC2PublicIP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)	
					echo -e  "Please follow next steps"
					echo -e "1. Copy the following web address: \e[92mhttp://$EC2PublicIP/index.php\e[0m"
					echo -e "2. Open a new tab in your prefered web browser (Firefox or Chrome)"
					echo -e "3. Paste the web address and press enter"
                                        echo -e "[ NOTE: PHP Info page should be displayed]"
					read -p "Did you was able to see the phpinfo page? " phpTestConfirm
                                        case $phpTestConfirm in
                                                [Yy]* ) echo -e "\n";echo -e "\e[92mThe evaluation of Apache Web Server + PHP was successfull.\e[0m";
							echo -e "\e[93m[NOTE:]\e[0m PHP Info test page was deleted for security best practices."
							echo "Congratulations this script was completed succesfully!"
							rm /var/www/html/index.php
							break;;
						[Nn]* ) echo -e "\n";echo -e "\e[93mThe evaluation of Apache Web Server + PHP was unsuccessful.\e[0m\n"
							echo -e "Please check the install.log file for more information\e[0m.\n"
							exit;;					
						esac 

					esac 
				done
                        fi
                    else
                        echo "Apache2 was succesfully installed with the PID: $apache2 as parent process ID."
                        apache2=""

                fi

		break;;
        [Nn]* ) echo -e "Script was not executed\e[0m"; exit;;
        [Cc]* ) echo -e "Next features that will be released soon:\e[0m"
		echo -e "- SSL module"
		echo -e "- Apache https template"
		echo -e "- Apache hardening"
		echo -e "- PHP Hardening"
		exit;;
        #* ) echo "Please answer yes to continue or no to cancel. Press c for customized setup.";;
    esac
done


