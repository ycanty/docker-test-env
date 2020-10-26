#!/usr/bin/env bash

# Setup the .env file with the current user's group and user ID's

if [ -f .env ]
then
  echo ".env file exists. Exiting."
  exit 0
fi

cat <<EOF > .env
USER=$(id -un)
UID=$(id -u)
GROUP=$(id -gn)
GID=$(id -g)
EOF

echo ".env file created with current user's ID's"