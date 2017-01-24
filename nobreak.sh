#!/bin/bash
DATA=`date +%d/%m/%Y`
HORA=`date +%H:%M:%S`
LOG=/var/log/nobreak.log
LOGFAIL=/var/log/nobreak-fail.log
ping -c "$2" "$1" | grep -in "64 bytes" > "$LOG"
CONTENTLOG="`cat $LOG`"
touch "$LOGFAIL"
if [ -z "$CONTENTLOG" ] 
then
  echo "----------------" >> "$LOGFAIL"
  echo "$DATA $HORA FAIL (ping $1)" >> "$LOGFAIL"
  ping -c "$3" "$1" >> "$LOGFAIL"
  echo "A ENERGIA CAIU!"
  echo "A ENERGIA CAIU!" >> "$LOGFAIL"
  echo "-----------------------------------------------------------------------------------------------" >> "$LOGFAIL"
  echo "$DATA $HORA - O SERVIDOR ANALISOU E DETECTOU QUEDA DE ENERGIA" >> "$LOGFAIL"
  echo "SLEEP DE $5 MINUTOS"
  sleep $4
  echo "NOVA TENTATIVA DE CONECTAR AO SERVIDOR"
  ping -c "$2" "$1" | grep -in "64 bytes" > "$LOG"
  CONTENTLOGT="`cat $LOG`"
  if [ -z "$CONTENTLOGT" ]
  then
    echo "A LUZ NAO RETORNOU EM $5 MINUTOS, DESLIGANDO SERVIDOR"
    echo "A LUZ NAO RETORNOU EM $5 MINUTOS, DESLIGANDO SERVIDOR" >> "$LOGFAIL"
    poweroff
  fi
fi
