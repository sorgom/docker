# ============================================================
# C++ build environment Dockerfile
# ============================================================

# base image
# since alpine does not provide a complete gcc - it is debian
FROM debian:12-slim
#FROM ubuntu:24.04
LABEL Description="C++ development environment"

# copy premake sources temporarily
ADD submodules/premake-core /premake-core

ADD submodules/bullseye /bullseye


RUN <<EOF
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
# cleanup sources
cd /
rm -rf /premake-core

# install bullseye coverage
cd /bullseye
./install --key 8FdIuJV2yQS6YGdoRSiRNedRj4uY5yKZS7bakBQnV3pT --search "$PATH" --prefix /usr/local/bullseye
# cleanup sources
cd /
rm -rf /bullseye
# add bullseye to PATH
echo "PATH=\"/usr/local/bullseye/bin:\$PATH\"" >> /etc/bash.bashrc
echo "export PATH" >> /etc/bash.bashrc

# add user dev
user=dev
home=/home/$user
# create user home directory
mkdir -p $home
# add user, password tt (theoretically never needed)
useradd -ms /bin/bash -d $home -p pacK1Ochismos $user
# sudo without password
echo "$user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

chown -R $user:$user $home
EOF

USER dev
