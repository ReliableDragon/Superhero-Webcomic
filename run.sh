#!/bin/bash
rm -rf /usr/share/nginx/html/*
sudo groupadd fuse
sudo usermod -aG fuse nginx
sudo chgrp fuse /dev/fuse
sudo chgrp nginx /usr/share/nginx/html
sudo chmod 775 /usr/share/nginx/html
sudo -u nginx gcsfuse --key-file /usr/local/bin/webcomic-key.json webcomic.gabesdemos.com /usr/share/nginx/html
exec "$@"