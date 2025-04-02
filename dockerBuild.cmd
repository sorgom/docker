@echo off
rem ============================================================
rem sample docker build script with 
rem - premake5
rem - Bullseye coverage
rem in vscode:
rem - just drag into a terminal window
rem ============================================================
rem created by Manfred Sorgo 

cd /d %~dp0
set keyFile=bullseye_key.txt
if not exist %keyFile% (
    echo %keyFile% required
    exit /b 1
)
docker build -t devenv:0.1 -t devenv:latest .
