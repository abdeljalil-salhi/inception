#!/bin/sh
if [ ! -f "/etc/vsftpd/vsftpd.conf.origin" ]; then
    mkdir -p $FTP_ROOTDIR
    cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.origin
    mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf
    adduser $FTP_USER --disabled-password
    echo "$FTP_USER:$FTP_PWD" | /usr/sbin/chpasswd
    chown -R $FTP_USER:$FTP_USER $FTP_ROOTDIR
    echo $FTP_USER | tee -a /etc/vsftpd.userlist &> /dev/null
fi
echo "FTP listening on $DOMAIN_NAME:21"
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf