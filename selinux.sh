#!/bin/bash

yum install httpd -y

systemctl start httpd.service
systemctl status httpd.service

yum install vsftpd -y

systemctl start vsftpd.service
systemctl status vsftpd.service

yum install policycoreutils policycoreutils-python selinux-policy selinux-policy-targeted libselinux-utils setroubleshoot-server setools setools-console mcstrans -y

echo "SELinux status is:"
sestatus

echo "Now the SELinux config file will open. Remember to change the mode only one level at a time!"
sleep 5

vim /etc/sysconfig/selinux

echo "The system will now reboot..."
sleep 5

reboot