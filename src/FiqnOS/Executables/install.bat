@echo off
CD /d %~dp0

mkdir %WINDIR%\Temp\FiqnOS
curl -L -o %WINDIR%\Temp\FiqnOS\VisualCppRedist_AIO_x86_x64.exe https://github.com/abbodi1406/vcredist/releases/download/v0.81.0/VisualCppRedist_AIO_x86_x64.exe
start %WINDIR%\Temp\FiqnOS\VisualCppRedist_AIO_x86_x64.exe /ai
curl -L -o %WINDIR%\Temp\FiqnOS\StartAllBack.reg https://github.com/f1qns/FiqnOS/releases/download/SAB/StartAllBack.reg
regedit StartAllBack /s
