@echo off
rem ============================================================
rem sample docker build script
rem in vscode:
rem - just drag into a terminal window
rem ============================================================
rem created by Manfred Sorgo 

cd /d %~dp0
docker build -t ubuntu_env:0.1 .
