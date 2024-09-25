@echo off
CD /d %~dp0

timeout /t 2 >nul
curl -g -k -L -# -o "C:\VisualCppRedist_AIO_x86_x64.exe" "https://github.com/abbodi1406/vcredist/releases/download/v0.83.0/VisualCppRedist_AIO_x86_x64.exe"
start /wait C:\VisualCppRedist_AIO_x86_x64.exe /ai
del /F /Q C:\VisualCppRedist_AIO_x86_x64.exe

timeout /t 2 >nul
curl -g -k -L -# -o "C:\dxwebsetup.exe" "https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe"
start /wait C:\dxwebsetup.exe /Q
del /F /Q C:\dxwebsetup.exe
