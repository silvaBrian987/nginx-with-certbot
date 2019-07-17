#!/bin/sh

if [ -z "$CERTBOT_CERTONLY" ];
    /usr/local/bin/certbot-auto certonly --nginx
else;
    /usr/local/bin/certbot-auto --nginx
fi;