# Info

This file describes how to run Mongo DB Replica Set on Docker.
We made an assumption that Docker IP address on host machine is `172.17.42.1` (and in most cases it's true).
You can verify it by running `ifconfig docker0` and checking ip address.

We're starting 3 docker containers with MongoDB, they are available on ports `27017`, `27018` and `27019`.

# Instructions

Clone this repository
```bash
$ git clone git@github.com:klivan/docker-mongodb-replicaset.git
```

Build docker image from Dockerfile
```bash
$ cd docker-mongodb-replicaset
$ docker build -t mongo .
```

Start docker containers with replica set
```bash
$ ./start.sh
```

Run one more Mongo docker container with bash
```bash
$ docker run -i -t mongo bash
```

And run script for Replica Set initialization:
```bash
$ ./replicaSet.sh
```
If you see an error during this step - please wait few minutes - most probably your docker containers haven't started yet.
You'll see something like this:
```bash
root@e4216ca7766f:/# ./replicaSet.sh
MongoDB shell version: 2.6.8
connecting to: 172.17.42.1:27017/test
{
	"info" : "Config now saved locally.  Should come online in about a minute.",
	"ok" : 1
}
bye
```

You can verify that eveything works by running `mongo` client and checking `rs.status()`:
```bash
root@29849b0f568c:/# mongo 172.17.42.1:27017
MongoDB shell version: 2.6.8
connecting to: 172.17.42.1:27017/test
rs0:PRIMARY> rs.status()
{
	"set" : "rs0",
	"date" : ISODate("2015-02-26T04:51:48Z"),
	"myState" : 1,
	"members" : [
		{
			"_id" : 0,
			"name" : "172.17.42.1:27017",
			"health" : 1,
			"state" : 1,
			"stateStr" : "PRIMARY",
			"uptime" : 448,
			"optime" : Timestamp(1424925935, 1),
			"optimeDate" : ISODate("2015-02-26T04:45:35Z"),
			"electionTime" : Timestamp(1424925946, 1),
			"electionDate" : ISODate("2015-02-26T04:45:46Z"),
			"self" : true
		},
		{
			"_id" : 1,
			"name" : "172.17.42.1:27018",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 370,
			"optime" : Timestamp(1424925935, 1),
			"optimeDate" : ISODate("2015-02-26T04:45:35Z"),
			"lastHeartbeat" : ISODate("2015-02-26T04:51:47Z"),
			"lastHeartbeatRecv" : ISODate("2015-02-26T04:51:47Z"),
			"pingMs" : 0,
			"syncingTo" : "172.17.42.1:27017"
		},
		{
			"_id" : 2,
			"name" : "172.17.42.1:27019",
			"health" : 1,
			"state" : 2,
			"stateStr" : "SECONDARY",
			"uptime" : 370,
			"optime" : Timestamp(1424925935, 1),
			"optimeDate" : ISODate("2015-02-26T04:45:35Z"),
			"lastHeartbeat" : ISODate("2015-02-26T04:51:47Z"),
			"lastHeartbeatRecv" : ISODate("2015-02-26T04:51:47Z"),
			"pingMs" : 1,
			"syncingTo" : "172.17.42.1:27017"
		}
	],
	"ok" : 1
}
rs0:PRIMARY>
```
