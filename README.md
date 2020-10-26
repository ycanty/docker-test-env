# Linux test environment docker container for MacOS

This project shows a working base recipe on how to start
a docker container running a Linux image as a non-root user,
with that user able to run docker from the container.

The solution targets Docker for Mac.  It has proven non-trivial
to get the `docker-in-docker` setup working on MacOS due to permissions
issues accessing the docker socket at `/var/run/docker.sock`.

This project shows one way to make it work.

## Configuration

Run `setup.sh` to create a `.env` file for your user and group ID.
Once generated, you can modify the content if you wish to create
an image with a different user or group.

(Optional) Take a look at `Dockerfile` and customize it to add any
extra commands you want in the image.

(Optional) Tweak `docker-compose.yml` if you require a more complex setup.

## Usage

Start the service with `docker-compose up -d --build`
Start a shell in the container with `docker-compose exec home /bin/bash` 
Shutdown with `docker-compose down`
