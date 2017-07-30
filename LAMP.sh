#!/bin/bash

# Ask if to perform full CentOS 7 update 

read -p "Perform full CentOS 7 system update? [y/n]" choice
case "$choice" in
  y|Y ) su -c 'yum update -y';;
  n|N ) echo "Continuing LAMP install...";;
  * ) echo "invalid";;
esac

# install apache 2 and inform when done

echo "Installing apache..."
sleep 5
yum install httpd -y
yum info httpd | grep repo | awk '{ print $3 }'

# install mariadb and inform when done

echo "Installing mariadb..."
sleep 5
yum install mariadb-server mariadb -y
yum info mariadb-server | grep repo | awk '{ print $3 }'

# install php and inform when done

echo "Installing php..."
sleep 5
yum install php php-mysql -y
yum info php | grep repo | awk '{ print $3 }'

# allow rw of /var/www/ and create info.php

echo "Allowing RW of /var/www/ and creating info.php..."
sleep 5
chmod 755 -R /var/www/
printf "<?php\nphpinfo();\n?>" > /var/www/html/info.php

#start services

echo "Starting services..."
sleep 5
systemctl start httpd.service
systemctl start mariadb.service

# require user input for  mysql_secure_installation

read -p "Next up MySQL secure installation which requires user input. Services will be enabled afterwards. Press ENTER to continue..."

# mariadb secure install

mysql_secure_installation

# restart and enable services to start with system

echo "Restarting and enabling services..."
sleep 5
systemctl restart httpd.service
systemctl restart mariadb.service
systemctl enable httpd.service
systemctl enable mariadb.service

# Add firewall rules for services

echo "Adding firewall rules for apache and reloading..."
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent
firewall-cmd --reload

# All done!
echo "All done!"