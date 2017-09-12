#!/bin/bash
set -e
[[ $DEBUG == true ]] && set -x

echoerr(){ echo 1>&2 "$@"; }
random(){ head -c 1K /dev/urandom | sha256sum | cut -d ' ' -f 1; }

await(){
     local server=$1 port=$2 sec=5 retry=0 retrymax=12
     until (echo > /dev/tcp/$server/$port) >/dev/null 2>&1; do
         (( retry++ ))
         echoerr "Waiting another $sec sec for $server:$port... ($retry/$retrymax)"
         sleep $sec
         (( $retry >= $retrymax )) && return 1
     done
     return 0
}

printenv

mongo_host=$MONGO_SERVICE_HOST
mongo_port=${MONGO_SERVICE_PORT:-27017}
await $mongo_host $mongo_port &&\
    export MONGO_URI="mongodb://$mongo_host:$mongo_port/crowi" || {
        echoerr "Connection timeout: mongodb"
        exit 1
    }

redis_host=$REDIS_SERVICE_HOST
redis_port=${REDIS_SERVICE_PORT:-6379}
await $redis_host $redis_port &&\
    export REDIS_URI="redis://$redis_host:$redis_port/crowi" ||\
    echoerr "Connection timeout: redis"

es_host=$ELASTICSEARCH_SERVICE_HOST
es_port=${ELASTICSEARCH_SERVICE_PORT:-9200}
await $es_host $es_port &&\
    export ELASTICSEARCH_URI="http://$es_host:$es_port/crowi" ||\
    echoerr "Connection timeout: elasticsearch"

export FILE_UPLOAD="local"
[[ -z $PASSWORD_SEED ]] &&\
    export PASSWORD_SEED=$(random)
[[ -z $SECRET_TOKEN ]] &&\
    export SECRET_TOKEN=$(random)

exec "$@"
