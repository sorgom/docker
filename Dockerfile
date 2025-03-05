FROM ubuntu:24.04
LABEL Description="build environment"

SHELL ["/bin/bash", "-c"]

ENV HOME=/home/som

ADD submodules/premake-core /premake-core

RUN <<EOF
# create user som and set home directory
mkdir -p $HOME
# user som, password tt
useradd -ms /bin/bash -d $HOME -p pacK1Ochismos som
chown -R som:som $HOME
# grant sudo privileges
echo "som ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# install packages
apt-get update
apt-get -y --no-install-recommends install build-essential uuid-dev cloc valgrind net-tools vim git ssh python3 python3-pip sudo
apt-get clean
rm -rf /var/lib/apt/lists/*

# build & copy premake
cd /premake-core
./Bootstrap.sh
cp bin/release/premake5 /usr/bin/
chmod +x /usr/bin/premake5
rm -rf /premake-core
EOF

USER som
WORKDIR $HOME
