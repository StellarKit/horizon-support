#!/bin/bash

set -e

export STELLAR_HOME="/opt/stellar"

export CORE_CONFIG="$STELLAR_HOME/stellar.cfg"
if [ $TESTNET -gt 0 ]
then
  export CORE_CONFIG="$STELLAR_HOME/stellar-testnet.cfg"
fi

function main() {
  echo ""
  echo "Starting Stellar Core"
  echo ""

  build-config /configs/.pgpass > /root/.pgpass
  chmod 600 /root/.pgpass

  while ! psql -h stellarpostgres -U $POSTGRES_USER -c 'select 1' coredb &> /dev/null
  do
    echo "Waiting for coredb to be available..."
    sleep 1
  done

  build-config /configs/stellar.cfg > $STELLAR_HOME/stellar.cfg
  build-config /configs/stellar-testnet.cfg > $STELLAR_HOME/stellar-testnet.cfg


  init_stellar_core

  /launch.sh
}

function init_stellar_core() {
  if [ -f $STELLAR_HOME/.core-initialized ]
  then
    echo "core: already initialized"
    return 0
  fi

  stellar-core --conf $CORE_CONFIG --newdb

  touch $STELLAR_HOME/.core-initialized
}

main
