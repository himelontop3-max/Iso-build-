@echo off

if not exist "%SystemDrive%\VRON" mkdir "%SystemDrive%\VRON"

reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" ^
 /v "VRON" /t REG_SZ ^
 /d "\"%SystemDrive%\VRON\VRON.Shell.exe\"" /f

exit /b 0
