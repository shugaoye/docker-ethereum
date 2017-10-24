#!/bin/bash
set -e

# Default to 'bash' if no arguments are provided
args="$@"
if [ -z "$args" ]; then
  args="bash"
fi

# Execute command as `aosp` user
export HOME=/home/ethereum
echo "args=$args"
exec $args --init-file /root/bash.bashrc
