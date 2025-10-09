#!/bin/bash
set -uex -o pipefail

exit 0 

# disabling in favor of extension
echo "Block distracting sites in /etc/hosts"
sudo bash -c 'cat >> /etc/hosts << EOF
127.0.0.1  imgur.com
127.0.0.1  reddit.com
127.0.0.1  twitter.com
127.0.0.1  news.ycombinator.com
EOF'
