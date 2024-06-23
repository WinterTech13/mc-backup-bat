REM MC Backup by WinterTech13

@echo off
title Minecraft Backup (Java)
cls
C:
cd "C:\Users\%USERNAME%\AppData\Roaming\.minecraft\saves"

echo.
echo Which world would you like to back up?
echo.
dir /a:d /b
echo.
set /p world=World Name: 
if not exist "%world%" goto error

cls
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set DateTime=%%a
set BackupName="%world%"_%DateTime:~4,2%%DateTime:~6,2%%DateTime:~0,4%%DateTime:~8,2%%DateTime:~10,2%
echo Backing up %world%...
tar.exe -a -cf %BackupName%.zip "%world%"
copy %BackupName%.zip C:\Users\%USERNAME%\Desktop\%BackupName%.zip
del %BackupName%.zip

cls
echo %world% backed up! Check the Desktop!
goto ex

:error
cls
echo The world you entered does not exist!
goto ex

:ex
pause
exit
