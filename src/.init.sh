#!/bin/sh

set -eu

# Send all output to stderr
exec 1>&2

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

if [ -z "$hostname" ]; then
  echo "Missing required variable \`hostname\`"
  exit 2
fi

# Default the port
port=${port:-22}

# Set common options
alias rsync="rsync --update --recursive --safe-links --copy-unsafe-links --perms --times --force --compress --progress --port=$port -e 'ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null'"

# Add the sshkey to the agent
if [ ! -z "$sshkey" ]; then
  # Don't need password if we have an sshkey
  unset password

  ssh-add <(echo "$sshkey")
fi

# Assemble the full target
target="$hostname"

if [ ! -z "$username" ]; then
  if [ ! -z "$password" ]; then
    username="$username:$password"
  fi

  target="$username@$target"
fi

target="$target:${directory:.}"

# .init
