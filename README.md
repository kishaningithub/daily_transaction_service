# Daily Transaction Service

API For personal transaction logging

## Local setup

* Install `docker`
* Install dependencies with `./build_scripts/local/install_deps.sh`
* Create and migrate your database with `./build_scripts/local/migrate_db.sh`
* Start Phoenix endpoint with `./build_scripts/local/start.sh`

## API Test drive

Creating a transaction

```bash
curl -X POST \
  http://localhost:4000/api/daily_transactions \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d '{
    "transaction_date" : "2017-12-04T14:12:38+05:30",
    "amount": 350,
    "type_of_transaction": "D",
    "description": "OLA Cab"
  }'
```

Listing all transactions

```bash
curl -X GET \
  http://localhost:4000/api/daily_transactions \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json'
```

## Running tests

```bash
./build_scripts/run_tests.sh
```