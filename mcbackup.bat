REM MC Backup by WinterTech13

@echo off
cls
C:
cd "C:\Users\%USERNAME%\AppData\Roaming\.minecraft\saves"

for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set DateTime=%%a
set Yr=%DateTime:~0,4%
set Mon=%DateTime:~4,2%
set Day=%DateTime:~6,2%
set Hr=%DateTime:~8,2%
set Min=%DateTime:~10,2%

echo.
echo What world would you like to back up?
echo.
dir /a:d /b
echo.
set /p do=World Name 

if not exist "%do%" goto error

set BackupName="%do%"_Backup%Mon%-%Day%-%Yr%(%Hr%%Min%)
tar.exe -a -cf %BackupName%.zip "%do%"
copy %BackupName%.zip C:\Users\%USERNAME%\Desktop\%BackupName%.zip
del %BackupName%.zip

cls
echo World Backed Up! (Check the desktop!)
goto ex

:error
echo The world you inputted does not exist! :O
goto ex

:ex
pause
exit
