#!/bin/bash
DATE=`date +%d/%m/%Y`
HOUR=`date +%H:%M:%S`
LOG=/var/log/nobreak.log
LOGFAIL=/var/log/nobreak-fail.log
MSG_POWER_OFF="The power is gone away"
MSG_LINE="-----------------------------------------------------------------------------------------------"
MSG_PING="$DATE $HOUR FAIL (ping $1)"
MSG_SLEEP="Sleep $5 minutes"
MSG_TRY="Try connect host..."
MSG_POWER_OFF_CONFIRM="The power do not return after $5 minutes, turn off server"

ping -c "$2" "$1" | grep -in "64 bytes" > "$LOG"
CONTENTLOG="`cat $LOG`"
touch "$LOGFAIL"
if [ -z "$CONTENTLOG" ] 
then
  echo $MSG_POWER_OFF
  echo $MSG_LINE >> "$LOGFAIL"
  echo $MSG_POWER_OFF >> "$LOGFAIL"
  echo $MSG_PING >> "$LOGFAIL"
  ping -c "$3" "$1" >> "$LOGFAIL"
  echo $MSG_LINE >> "$LOGFAIL"
  echo $MSG_SLEEP
  echo $MSG_SLEEP >> "$LOGFAIL"
  sleep $4
  DATE=`date +%d/%m/%Y`
  HOUR=`date +%H:%M:%S`
  echo $MSG_TRY
  echo $MSG_TRY >> "$LOGFAIL"
  echo $MSG_LINE >> "$LOGFAIL"
  MSG_PING="$DATE $HOUR FAIL (ping $1)"
  ping -c "$2" "$1" | grep -in "64 bytes" > "$LOG"
  CONTENTLOGT="`cat $LOG`"
  if [ -z "$CONTENTLOGT" ]
  then
    ping -c "$3" "$1" >> "$LOGFAIL"
    echo $MSG_LINE >> "$LOGFAIL"
    echo $MSG_POWER_OFF_CONFIRM
    echo $MSG_POWER_OFF_CONFIRM >> "$LOGFAIL"
    # shutdown -r 1 "The server will reboot in 1 minute"
  fi
fi