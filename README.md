## StellarKit Horizon Support

You want to run Horizon under a debugger?  You'll need stellar-core and postgres running.
This project creates a docker instance that runs stellar core and postgres with two tables, coredb and horizondb
Run VSCode, open stellar/go put this in your launch.json

```
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
```

Run the docker:

    docker-compose build
    docker-compose up -d

 Now click the Launch button in VSCode on top left and it will run Horizon and use this core/postgress and you can debug.
