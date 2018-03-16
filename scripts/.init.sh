#!/bin/sh

set -eu

###
# ===========
#  Variables
# ===========
# The following variables will be used and should or can be passed in
#
#   |   key     | required? | default | description                            |
#   | --------- | --------- | ------- | -------------------------------------- |
#   | hostname  | required  |  null   | The host to copy to or from            |
#   | username  | optional  | 'root'  | The user that will SSH to the machine  |
#   | password  | optional  |  null   | The password to login with             |
#   | sshkey    | optional  |  null   | The private key to login with          |
#   | port      | optional  |   22    | The port to connect to for SSH         |
#   | directory | optional  |   '.'   | The directory to place contents under  |
#
##

if [ -z ${hostname+x} ]; then
  echo "Missing required variable \`hostname\`"
  exit 2
fi

# Default the port
port=${port:-22}
username="${username:-root}"
password="${password:-}"
sshkey="${sshkey:-}"
directory="${directory:-.}"

# Set common options
RSYNC_OPTIONS="--update --recursive --safe-links --copy-unsafe-links --perms --times --force --compress --progress --port=$port"
SSH_OPTIONS="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"

# Add the sshkey to the agent
if [ ! -z "$sshkey" ]; then
  # Don't need password if we have an sshkey
  unset password

  echo "$sshkey" > /root/provided_sshkey
  SSH_OPTIONS="$SSH_OPTIONS -i /root/provided_sshkey"
fi

if [ ! -z ${password+x} ]; then
  if [ ! -z "$password" ]; then
    SSH_OPTIONS="sshpass -p '$password' $SSH_OPTIONS"
  fi
fi

# Create an rsync alias
alias rsync="rsync $RSYNC_OPTIONS --rsh='$SSH_OPTIONS'"

# Assemble the full target
target="$hostname"

if [ ! -z "$username" ]; then
  target="$username@$target"
fi

from="${from:-.}"
dest="${dest:-$from}"

# .init
