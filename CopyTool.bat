@echo off
mode 60, 10
set bar=o
:bar
cls
echo Copying the folder...
echo [%bar%]
set bar=o%bar%
if "%bar%"=="ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo" goto end
goto bar
:end
cls
echo Copying the folder...
echo [ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo]
if not exist %systemdrive%\vivetool mkdir %systemdrive%\vivetool
cd "%~dp0"
echo.
copy /Y vivetool\* %systemdrive%\vivetool\
if not exist %systemdrive%\vivetool\Albacore.ViVe.dll goto :reattempt
if not exist %systemdrive%\vivetool\ViVeTool.exe goto :reattempt

if exist Albacore.ViVe.dll if exist ViVeTool.exe goto :continue
:continue
rmdir /S /Q vivetool
echo.
timeout /t 2 /nobreak > NUL
exit



:reattempt
copy /Y vivetool\* %systemdrive%\vivetool\
if exist Albacore.ViVe.dll if exist ViVeTool.exe goto :continue
if not exist %systemdrive%\vivetool\Albacore.ViVe.dll goto :reattempt
if not exist %systemdrive%\vivetool\ViVeTool.exe goto :reattempt