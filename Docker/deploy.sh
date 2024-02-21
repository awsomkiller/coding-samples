#!/bin/bash

helpFunction()
{
    echo ""
    echo "Usage: $0"
    echo "\t Command build / pull / push / up / down"
    exit 1
}

export $(grep -v '^#' compose-files/.env | xargs)

if [ -z $1 ]
then
    echo "You must give the command"
    helpFunction
fi

if [ $ENVIRONMENT = "production" ] && [ $1 = "build" ]
then
    docker compose \
        -f ./compose-files/docker-compose.prod.yml \
        -f ./compose-files/infra/docker-compose.redis.prod.yml \
        -f ./compose-files/infra/docker-compose.db.prod.yml \
        -f ./compose-files/backend/docker-compose.backend.prod.yml \
        -f ./compose-files/infra/docker-compose.celery.prod.yml \
        -f ./compose-files/infra/docker-compose.elastic.prod.yml \
        -f ./compose-files/frontend/docker-compose.frontend.prod.yml \
        -f ./compose-files/infra/docker-compose.nginx.prod.yml \
        "$1";

    docker push docker-registry.setera.com/my-backend-django:"$BACKENDTAG"
    docker push docker-registry.setera.com/my-backend-celery:"$BACKENDTAG"
    docker push docker-registry.setera.com/my-backend-celery-beat:"$BACKENDTAG"
    docker push docker-registry.setera.com/my-nginx:"$NGINXTAG"
fi

if [ $ENVIRONMENT = "production" ] && [ $1 = "up" ]
then
    docker compose \
        -f ./compose-files/docker-compose.prod.yml \
        -f ./compose-files/infra/docker-compose.redis.prod.yml \
        -f ./compose-files/infra/docker-compose.db.prod.yml \
        -f ./compose-files/backend/docker-compose.backend.prod.yml \
        -f ./compose-files/infra/docker-compose.celery.prod.yml \
        -f ./compose-files/infra/docker-compose.elastic.prod.yml \
        -f ./compose-files/infra/docker-compose.nginx.prod.yml \
        "$1" -d;
fi

if [ $ENVIRONMENT = "production" ] && [ $1 != "build" ] && [ $1 != "up" ]
then
    docker compose \
        -f ./compose-files/docker-compose.prod.yml \
        -f ./compose-files/infra/docker-compose.redis.prod.yml \
        -f ./compose-files/infra/docker-compose.db.prod.yml \
        -f ./compose-files/backend/docker-compose.backend.prod.yml \
        -f ./compose-files/infra/docker-compose.celery.prod.yml \
        -f ./compose-files/infra/docker-compose.elastic.prod.yml \
        -f ./compose-files/infra/docker-compose.nginx.prod.yml \
        "$1";
fi

if [ $ENVIRONMENT = "stage" ]
then
    docker compose \
        -f ./compose-files/docker-compose.stage.yml \
        -f ./compose-files/infra/docker-compose.redis.stage.yml \
        -f ./compose-files/infra/docker-compose.db.stage.yml \
        -f ./compose-files/backend/docker-compose.backend.stage.yml \
        -f ./compose-files/infra/docker-compose.celery.stage.yml \
        -f ./compose-files/frontend/docker-compose.frontend.stage.yml \
        -f ./compose-files/infra/docker-compose.nginx.stage.yml \
        "$1";
fi

if [ $ENVIRONMENT = "dev" ]
then
    docker compose \
        -f ./compose-files/docker-compose.dev.yml \
        -f ./compose-files/infra/docker-compose.nginx.dev.yml \
        -f ./compose-files/infra/docker-compose.redis.dev.yml \
        -f ./compose-files/infra/docker-compose.db.dev.yml \
        -f ./compose-files/backend/docker-compose.backend.dev.yml \
        -f ./compose-files/infra/docker-compose.celery.dev.yml \
        -f ./compose-files/infra/docker-compose.elastic.dev.yml \
        -f ./compose-files/frontend/docker-compose.frontend.dev.yml \
        "$1";
fi

exit 1
