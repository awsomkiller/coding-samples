## To push the docker images we need to login to the dockerregistery first

 `$ docker login <registry-url>`
  
  or in our case
 
 `$ docker login docker-registry.setera.com`


## To build the docker images go to the respective repo, for e.g

- To build the docker image for backend, celery and celery-beat go to the my-setera-BACKEND, configure the .env file from .env-example and execute the command demonstrated below for the given services.
-[Setup: Image creation for Celery, Celery-beat, backend]
  - `$ docker build -t <organization-name>/<image-name>:<tag> .`
 #
  - `$ docker build -t docker-registry.setera.com/backend:latest .`
  - `$ docker build -t docker-registry.setera.com/celery:latest .`
  - `$ docker build -t docker-registry.setera.com/celery-beat:latest .`
   you can give the image-name like ['backend', 'celery', 'celery-beat'] and tage them as 'latest' or a specific version if needed.

- To build the docker image for frontend go to the my-setera-UI repositry, configure the .env file from .env-example and run the same command as below
-[Setup: Image creation for Frontend]
  - `$ docker build -t <organization-name>/<image-name>:<tag> .`
  #
  - `$ docker build -t docker-registry.setera.com/frontend:latest .`

  #

- To build the docker image of nginx got to the my-setera-deployment repository, navigate to prod/compose-files/infra/nginx/ and run the same command as below.
-[Setup: Image creation for NGINX]
  - `$ docker build -t <organization-name>/<image-name>:<tag> .`
  #
  - `$ docker build -t docker-registry.setera.com/nginx:latest .`

## After creating the images we need to push the docker images to the my-setera docker registery
 - `docker push <organization-name>/<image-name>:<tag>`
 #
  - `docker push docker-registry.setera.com/backend:latest`
  - `docker push docker-registry.setera.com/celery:latest`
  - `docker push docker-registry.setera.com/celery-beat:latest`
  - `docker push docker-registry.setera.com/frontend:latest`


## steps to deploy on local
 ### Prequirites
- backend, frontend and current repo should be cloned at same level (cloned in same directory)

#

- `$ cd dev && ./dev.sh build --no-cache && ./dev.sh up -d`

## To deploy in stage, first create the docker images and push them to the setera docker registery and then run the below command
- `$ cd stage && ./stage.sh build --no-cache && ./stage.sh up -d`

## To deploy in production, first create the docker images and push them to the setera docker registery and then run the below command
- `$ cd prod && ./prod.sh build --no-cache && ./prod.sh up -d`

# Note:
 keep the ssl certificates in respective directories <dev|stage|prod>/compose-files/infra/nginx/certs directory.
 please refer to the respective docker-compose.yml files for the naming convention and feel free to adjust the configurations according to your needs and images names in docker-compose files according to the names you choose while building the docker images from the respective direcctories.

 # Exclusive production setup:
  ## Create docker build/Image in following sequence
   1. my_backend/django
   2. my_backend/celery
   3. my_backend/celery-beat
   4. frontend
   5. nginx

  ## Instruction for creating docker Image
    To create image execute the command in following manner

    - `$ docker build -f <dockerfile:path> -t <tag> .`
    - `$ docker build -f Dockerfile.prod -t docker-registry.setera.com/my-backend-django:${BACKENDTAG} .`

  - Once sequence are created, push them to the setera docker registery and update the respective tag in .env

  ## Execute the following command once all steps are completed
  - `$ ./prod.sh up -d`