# vivox-redis-benchmark
This branch documents the benchmark numbers for Redis commands: MGET, SSCAN, HSCAN, SMEMBERS & HGETALL using the eredis client to measure the MongooseIM's Redis SM backend performance

**Requirements**:
Local Redis server, eredis Redis client, erlang

## Quick Start
```
brew install erlang redis
/usr/local/opt/redis/bin/redis-server /usr/local/etc/redis.conf
git clone git clone git://github.com/wooga/eredis.git
cp *.erl eredis/
cd eredis
make all
erl -pa ebin/

#on erlang shell, run each test e.g.
>c(hscan).
>hscan:start().
```
