# Unlimited Process Works

## Overview

This project is a concept model for unlimted scale system for customer base system.
Basic idea is every user has dedicated database.
Almost customer system is only be careful about own data. They don't be careful about other people data.

First of all, this system run docker container by each request.
And each docker is attached sqlite by each user and synchronize to postgresql as global-database.

So this is a perfect MPP archtecture and very simple sharding style.
Of course, this is not able to be used on production. But it's helpful to understanding the characteristics of customer system.

## Compornent

<table>
    <tr><th>Name</th><th>Description</th></tr>
    <tr>
        <td>Dispatcher</td>
        <td>Web request end-point. It runs worker process container like CGI.</td>
    </tr>
    <tr>
        <td>Worker</td>
        <td>Worker process Docker. It execute actual tasks. And it's attached sqlite.</td>
    </tr>
    <tr>
        <td>Async ETL</td>
        <td>Asyncronaize data to global-db</td>
    </tr>
</table>

## System Flow

```plantuml
left to right direction
agent Dispatcher
agent Worker1
agent Worker2
agent WorkerN
agent AsyncETL
database sqlite_for_userA
database sqlite_for_userB
database sqlite_for_userC
database global_db
actor Customer

Customer --> Dispatcher
Dispatcher --> Worker1
Dispatcher --> Worker2
Dispatcher --> WorkerN
Worker1 --> sqlite_for_userA
Worker2 --> sqlite_for_userB
WorkerN --> sqlite_for_userC
Worker1 --> AsyncETL
Worker2 --> AsyncETL
WorkerN --> AsyncETL
AsyncETL --> global_db
```

## How to use

### Build and Run

```bash
$ ./build.sh
$ docker-compose up
```

### Operation

```bash
# Create Account
$ curl http://0.0.0.0/koduki/create
Hello, koduki. Welcome Unlimited Process Works!

# Deposit
$ curl http://0.0.0.0/koduki/deposit/128
koduki's account deposit 128 yen.
$ curl http://0.0.0.0/koduki/deposit/128
koduki's account deposit 128 yen.

# Show
$ curl http://0.0.0.0/koduki/show
koduki's account is 256 yen.

# Summary
% curl http://0.0.0.0/account_summary
nanoha, 156
koduki, 256
misuzu, 75
```

###
