REM MC Backup by WinterTech13

@echo off
title Minecraft Backup
C:
cls
echo.
echo Which edition would you like to back up a world from?
echo.
echo 1) Java
echo 2) Bedrock
echo.
set /p game=Edition: 
if %game%== 1 goto java
if %game%== 2 goto bedrock
cls
echo Invalid selection!
goto ex

:java
title Minecraft Backup (Java)
cls
cd "C:\Users\%USERNAME%\AppData\Roaming\.minecraft\saves"

echo.
echo Which world would you like to back up?
echo.
dir /a:d /b
echo.
set /p world=World Name: 

if not exist "%world%" goto error
set selectedWorld=%world%
goto backup

:bedrock
setlocal EnableDelayedExpansion
title Minecraft Backup (Bedrock)
cls
cd "%localappdata%\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\minecraftWorlds"
for /d %%d in ("*") do (
    set worldFolders=!worldFolders! "%%d"
    cd "%%d"
    set /p worldName=<"levelname.txt"
    set worldNames=!worldNames! "!worldName!"
    cd ..
)

echo.
echo Which world would you like to back up?
echo.
for %%a in (%worldNames%) do (
    echo %%~a
)
echo.
set /p selectedWorld=World name: 
set i=1
for %%a in (%worldNames%) do (
    if /I "%selectedWorld%"=="%%~a" (
        goto bbu
    )
    set /a i+=1
)
goto error

:bbu
set /a index=0
for %%d in (%worldFolders%) do (
    set /a index+=1
    if !index! == %i% (
        set world=%%~d
    )
)
goto backup

:backup
setlocal DisableDelayedExpansion
cls
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set DateTime=%%a
set BackupName="%selectedWorld%"_%DateTime:~4,2%%DateTime:~6,2%%DateTime:~0,4%%DateTime:~8,2%%DateTime:~10,2%

echo Backing up %selectedWorld%...
tar.exe -a -cf %BackupName%.zip "%world%"
copy %BackupName%.zip C:\Users\%USERNAME%\Desktop\%BackupName%.zip
del %BackupName%.zip
cls
echo %selectedWorld% backed up! Check the Desktop.
goto ex

:error
setlocal DisableDelayedExpansion
cls
echo The world you entered does not exist!
goto ex

:ex
pause
exit
