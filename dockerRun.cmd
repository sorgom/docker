@echo off
rem ============================================================
rem sample docker run script
rem in vscode:
rem - just drag into a terminal window
rem ============================================================
rem created by Manfred Sorgo 
SETLOCAL

cd /d %~dp0
set myDir=%cd%
rem regard folder above as git repositories folder
cd ..
set gitDir=%cd%

rem set image
set image=ubuntu_env:0.1

rem set mount to git repositories folder as /git
set gitMount=--mount type=bind,source=%gitDir%,target=/git
rem overwrite image home folder with local
rem advantage: 
rem - histories are saved in local
rem - id est: histories don't get lost with each container start / exit
set somMount=--mount type=bind,source=%myDir%/som,target=/home/som

rem optional ports mapping sample
rem set portsmap=-p 127.0.0.1:8081:8091/tcp -p 127.0.0.1:8082:8092/tcp -p 127.0.0.1:8083:8093/tcp
set portsmap=

docker run -it --rm --name=somdev %gitMount% %somMount% %portsmap% %image%
