#!/bin/sh

# Set the password if provided
if [ ! -z ${ROOT_PASSWORD+x} ]; then
  echo "root:$ROOT_PASSWORD" | chpasswd
  echo "root login password: $ROOT_PASSWORD"
fi

if [ ! -f /etc/ssh/ssh_host_rsa_key ]; then
  ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
fi

# Launch supervisor
supervisord -n

# entrypoint
