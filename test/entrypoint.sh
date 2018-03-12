#!/bin/sh

export ROOT_PASSWORD=`pwgen -c -n -1 12`

ssh $username@$hostname -c "echo 'root:$ROOT_PASSWORD' | chpasswd"

echo "Changed root password to $ROOT_PASSWORD"
echo $ROOT_PASSWORD > /root/.password.txt

export password=$ROOT_PASSWORD

supervisord -n

# entrypoint
