# ============================================================
# C++ build environment Dockerfile
# ============================================================

# base image
# since alpine does not provide a complete gcc - it is debian
FROM debian:12-slim
LABEL Description="C++ development environment"

# copy premake sources temporarily
ADD submodules/premake-core /premake-core

RUN <<EOF
user=dev
home=/home/$user
# create user home directory
mkdir -p $home
# add user, password tt (theoretically never needed)
useradd -ms /bin/bash -d $home -p pacK1Ochismos $user
# grant sudo privileges without password
echo "$user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

chown -R $user:$user $home

# install packages
# update  
apt-get update
# install function
_install() { apt-get -y --no-install-recommends install "$@"; }
# C++ minimal
_install make g++ uuid-dev
# analysis
_install cloc valgrind cppcheck net-tools
# python latest version
_install python3 python3-pip
apt-get upgrade -y python3
# git (ssh for github / gitlab)
_install git ssh
# maintenance / documentation
_install sudo vim tree

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
