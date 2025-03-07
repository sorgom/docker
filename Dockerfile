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
#   - cppcheck
#   - valgrind
#   - cloc
#   - vim
# - build from source as submodule:
#   - premake5
# ============================================================

# base image
# since alpine does not provide a complete gcc - it is ubuntu
FROM ubuntu:24.04
LABEL Description="build environment"

# copy premake sources temporarily
ADD submodules/premake-core /premake-core

RUN <<EOF
user=dev
home=/home/$user
# create user som and set home directory
mkdir -p $home
# user password tt (theoretically never needed)
useradd -ms /bin/bash -d $home -p pacK1Ochismos $user
# grant sudo privileges without password
echo "$user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

chown -R $user:$user $home

# install packages
_install() { apt-get -y --no-install-recommends install "$@"; }
apt-get update
# build (build-essential, uuid-dev for premake build)
_install build-essential uuid-dev
# analysis
_install cloc valgrind cppcheck net-tools
# python latest version
_install python3 python3-pip
apt-get upgrade -y python3
# git (ssh for github / gitlab)
_install git ssh
# maintenance
_install sudo vim

# cleanup
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

USER dev
