FROM ubuntu:24.04
LABEL Description="build environment"


SHELL ["/bin/bash", "-c"]

ENV HOME=/home/som


ADD submodules/premake-core /premake-core

RUN <<EOF
# create user ms and set home directory
mkdir -p $HOME
useradd -ms /bin/bash -d $HOME som
chown -R som:som $HOME
# grant root privileges
echo "ms ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# install packages
apt-get update
apt-get -y --no-install-recommends install build-essential uuid-dev cloc valgrind net-tools vim
apt-get clean
rm -rf /var/lib/apt/lists/*

# build & install premake
cd /premake-core
./Bootstrap.sh
cp bin/release/premake5 /usr/bin/
chmod +x /usr/bin/premake5
rm -rf /premake-core
EOF

USER som
WORKDIR $HOME
