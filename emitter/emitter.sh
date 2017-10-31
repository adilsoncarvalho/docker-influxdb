#!/bin/sh

function log {
  echo "[$(date -u +'%F %T %z')] $1"
}

function finish {
  log "==> STOP!"
}

trap finish EXIT

ACTIONS=("pageview" "sale")
PAYMENT_TYPE=("credit" "debit" "statement")
STATUSES=("success" "failed" "waiting")

log "==> START"

curl -POST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE mydb"

while :
do
  RANDOM=$$$(date +%s)

  for i in `seq 1 5`;
  do
    ACTION="${ACTIONS[$RANDOM % ${#ACTIONS[@]}]}"
    PAYMENT=""
    STATUS=""

    if [[ "pageview" != "$ACTION" ]]; then
      PAYMENT="payment=${PAYMENT_TYPE[$RANDOM % ${#PAYMENT_TYPE[@]}]}"
      STATUS="status=${STATUSES[$RANDOM % ${#STATUSES[@]}]}"
      ATTRIBUTES=",$PAYMENT,$STATUS value=36.0"
    fi

    echo "---> $ACTION $PAYMENT $STATUS"
    curl -i \
      -XPOST 'http://localhost:8086/write?db=mydb' \
      --data-binary "$ACTION$ATTRIBUTES"
  done;

  log "-> do something"

  log "-> Waiting for 15 seconds"
  sleep 15
done
