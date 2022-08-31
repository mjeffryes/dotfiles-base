#!/bin/bash
set -uex -o pipefail

echo "Block distracting sites in /etc/hosts"
cat >> /etc/hosts << EOF
127.0.0.1  imgur.com
127.0.0.1  reddit.com
127.0.0.1  twitter.com
127.0.0.1  news.ycombinator.com

EOF
