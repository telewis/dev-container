#!/bin/bash

while true
do
  theDate=$(date)
  theHour=$(date "+%H")
  echo "${theDate} :: ${0}" >> /var/log/keepalive/keepalive.${theHour}
  sleep 600
done