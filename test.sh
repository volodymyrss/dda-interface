CONTAINER_NAME=${1:?}

SCRATCH=${SCRATCH:-/tmp/scratch}
LOGS=${LOGS:-/tmp/logs}

echo ${WORKER_MODE:=interface}

mkdir -pv $SCRATCH $LOGS


docker rm -f $CONTAINER_NAME
docker run \
    --net local \
    -v netrc-integral-containers:/home/integral/.netrc \
    -v sentry-key:/home/integral/.sentry-key \
    -v mattermost-hook:/home/integral/.mattermost-hook \
    -v secret-ddosa-server:/home/integral/.secret-ddosa-server \
    -v jupyter_notebook_config.json:/home/integral/.jupyter/jupyter_notebook_config.json \
    -v $SCRATCH:/scratch \
    -v $LOGS:/var/log/containers \
    -e DDA_QUEUE=queue-osa11 \
    -e WORKER_MODE=${WORKER_MODE} \
    -e DDA_INTERFACE_TOKEN="" \
    -e CURRENT_IC="/data" \
    -e INTEGRAL_DATA="/data" \
    -e REP_BASE_PROD="/data" \
    --name dda-${WORKER_MODE} \
    -p 8100:8000 \
    -e DQUEUE_DATABASE_URL="mysql+pool://root:$(cat test-password)@dqueue-mysql/dqueue?max_connections=42&stale_timeout=8001.2" \
    --rm \
    $CONTAINER_NAME &

sleep 2


echo "healthcheck"
curl http://localhost:8100/healthcheck

export DDA_INTERFACE_URL=http://localhost:8100/
export DDA_TOKEN=""
echo "ii_skyimage"
dda-client -D -v ii_skyimage -m git://ddosa -a 'ddosa.ScWData(input_scwid="066500220010.001")' 

docker rm -f dda-${WORKER_MODE}
