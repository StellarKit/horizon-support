### StellarKit Horizon Support

You want to run Horizon under a debugger?  You'll need stellar-core and postgres running.
This project creates a docker instance that runs stellar core and postgres with two tables, coredb and horizondb.
Run VSCode, open stellar/go put this in your launch.json

```
"configurations": [
    {
      "name": "Launch",
      ...
      "env": {
               "DATABASE_URL": "postgres://stellar:password@localhost:6432/horizondb?sslmode=disable",
               "STELLAR_CORE_DATABASE_URL": "postgres://stellar:password@localhost:6432/coredb?sslmode=disable",
               "STELLAR_CORE_URL": "http://localhost:11626",
               "PER_HOUR_RATE_LIMIT": 72000,
               "FRIENDBOT_URL": "http://localhost:8004/",
               "LOG_LEVEL": "info",
               "INGEST": "true",
               "NETWORK_PASSPHRASE": "Test SDF Network ; September 2015",
               "HISTORY_RETENTION_COUNT": 864000,
               "ALLOW_EMPTY_LEDGER_DATA_RESPONSES": "true"
              },
     ...
   }
```

Run the docker:

    docker-compose build
    docker-compose up -d

 Now click the Launch button in VSCode on top left and it will run Horizon and use this core/postgress and you can debug.

You can monitor stellar-core with:

```
docker logs --tail=500 --follow support-core
```

Or you can omit the -d and see the output from core

### Run the Friendbot

You have to launch this separately.  This is optional and uneccessary (but fun).

Go to go/services/friendbot and type 'go build'

Edit the friendbot.cfg.

* Change port to 8004 (matches what is set above)
* Create a new account and add a bunch of testnet stellar
* Fill in friendbot_secret with the secret from the new account
* horizon_url = "http://localhost:8000"
* starting_balance = "100.00"  (or more if you want)

Launch friendbot:
```
  $ ./friendbot
```

Create a new keypair on [Stellar Laboratory](https://www.stellar.org/laboratory/#account-creator?network=test)

Friendbot requests look like http://localhost:8000/friendbot?addr=G..X

Horizon is set to forward /friendbot to your service on 8004
