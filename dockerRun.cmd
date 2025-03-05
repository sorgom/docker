@echo off
SETLOCAL

cd /d %~dp0
set myDir=%cd%
cd ..
set gitDir=%cd%

set image=ubuntu_env:0.1
set gitMount=--mount type=bind,source=%gitDir%,target=/git
set somMount=--mount type=bind,source=%myDir%/som,target=/home/som
@REM set portsmap=-p 127.0.0.1:8081:8091/tcp -p 127.0.0.1:8082:8092/tcp -p 127.0.0.1:8083:8093/tcp

docker run -it --rm --name=somdev %gitMount% %somMount% %portsmap% %image%
