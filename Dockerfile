# ============================================================
# Build environment Dockerfile
# - user: som
#   - password: tt
#   - sudo privileges without password
# - packages:
#   - C++ development and analysis
#   - python
#   - netstat
#   - git
#   - ssh for git
# - build from source as submodule:
#     - premake5
# ============================================================

# base image
# since alpine does not provide a complete gcc - it is ubuntu
FROM ubuntu:24.04
LABEL Description="build environment"

SHELL ["/bin/bash", "-c"]

ENV HOME=/home/som

# copy premake sources temporarily
ADD submodules/premake-core /premake-core

RUN <<EOF
# create user som and set home directory
mkdir -p $HOME
# user som, password tt
# (password theoretically never needed)
useradd -ms /bin/bash -d $HOME -p pacK1Ochismos som
# grant sudo privileges without password
echo "som ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

chown -R som:som $HOME

# install packages
apt-get update
apt-get -y --no-install-recommends install build-essential uuid-dev cloc valgrind net-tools vim git ssh python3 sudo
apt-get upgrade -y python3
apt-get clean
rm -rf /var/lib/apt/lists/*

# build premake
cd /premake-core
./Bootstrap.sh

# copy premake binary to /usr/bin and make it executable
cp bin/release/premake5 /usr/bin/
chmod +x /usr/bin/premake5

# cleanup premake sources
rm -rf /premake-core
EOF

USER som
WORKDIR $HOME
