#!/bin/bash

sleep 5

echo "$(date): Resume detected" >> /var/log/puppis-share.log

systemctl restart puppis-share.service
