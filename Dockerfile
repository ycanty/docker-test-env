FROM ubuntu:latest

# Install utilities
RUN apt-get update && apt-get install -y curl sudo && rm -rf /var/lib/apt/lists/*

# Install docker
RUN curl -fsSL https://get.docker.com | sh && rm -rf /var/lib/apt/lists/*

# Create user and group.
# We create the user's home directory under /Users/ for better compatibility with Docker for Mac,
# which doesn't easily allow to bind mount folders from /home.
ARG UID=1000
ARG USER=1000
ARG GID=1000
ARG GROUP=1000
RUN grep -q "${GROUP}:" /etc/group && groupdel ${GROUP}; \
    if [ "$(getent group ${GID} | cut -d: -f 1)" != "" ]; then groupdel "$(getent group ${GID} | cut -d: -f 1)"; fi; \
    groupadd -g ${GID} ${GROUP} && \
    useradd -b /Users -m -g ${GID} -s /bin/bash -u ${UID} ${USER} && \
    echo "${USER}:system" | chpasswd

# sudo without a password
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# To avoid permission denied accessing MacOS host's docker socket, we could do this, however this
# changes the permissions inside the hyperkit VM if it's mounted from /var/run/docker.sock.raw and it's
# best to avoid messing with the docker VM
#RUN echo "test -S /var/run/docker.sock && sudo chown ${UID}:${GID} /var/run/docker.sock" >> /Users/${USER}/.bashrc

WORKDIR /Users/${USER}
USER ${USER}
