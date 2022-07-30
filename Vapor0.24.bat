@echo off
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
cd "%~dp0"
mode 130, 30
title Vapor 0.24
echo.
echo    Vapor is a script which, with the help of ViveTool (github.com/thebookisclosed/ViVe), lets you enable Tabs in File Explorer.
echo    With Vapor 0.24, you can also enable the new Task Manager.
echo    This is just a script made by FranzaGeek to automate the enablement process.
echo.
echo    For this to work, you need to have at least Windows 11 build 22572. With older versions this would not work.
echo.
echo.
echo All you need is to follow a few on-screen steps. You have to choose whether to confirm or not.
echo Press C to begin. Else, to quit this program just press Q.
echo.
choice /c cq /N /M ^>
if %errorlevel%==1 goto 1step
if %errorlevel%==2 exit
:1step
echo.
echo Great! You chose to continue. Now, we have to copy the ViveTool folder to the C:\ folder.
echo Press C to copy the folder to the C:\ folder. Else, to quit this program just press Q.
echo.
choice /c cq /N /M ^>
if %errorlevel%==1 goto 2step
if %errorlevel%==2 exit
:2step
echo.
echo Awesome, you still want to continue! One moment, we're copying the ViveTool folder...
call :CopyTool
echo Perfect! The folder has been copied. Now, we have to execute some commands. 
echo Don't worry: none of these commands are dangerous.
echo.
echo Choose what to do:
echo.
echo [1] Enable tabs only
echo [2] Enable the new Task Manager only
echo [3] Enable both the new Task Manager and the tabs.
echo [Q] Quit
echo.
choice /c 123q /N /M ^>

if %errorlevel%==4 exit
if %errorlevel%==3 call :ApplyConfig tabs taskmgr
if %errorlevel%==2 call :ApplyConfig taskmgr
if %errorlevel%==1 call :ApplyConfig tabs

:3step
echo.
echo Done!
echo.
echo Alright, now we are at the last step. You have to restart the computer.
echo Press C to restart your PC now. Else, to quit this program and restart your PC later just press Q.
echo.
choice /c cq /N /M ^>
if %errorlevel%==1 goto :restart
if %errorlevel%==2 exit

:restart
echo.
echo Thanks for using Vapor. Bye!
timeout /t 2 /nobreak > NUL
shutdown /r /c "Vapor has scheduled a restart as you requested. Press 'Close' to restart."
exit




:CopyTool
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
cls
goto :eof

:reattempt
copy /Y vivetool\* %systemdrive%\vivetool\
if exist Albacore.ViVe.dll if exist ViVeTool.exe goto :continue
if not exist %systemdrive%\vivetool\Albacore.ViVe.dll goto :reattempt
if not exist %systemdrive%\vivetool\ViVeTool.exe goto :reattempt


:ApplyConfig
if "%1"=="tabs" (
	if "%2"=="taskmgr" (
	 	echo.
		echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		echo Adding Task Manager... 
		echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
		echo.
		cd C:\
		cd vivetool
		vivetool addconfig 35908098 2
		cd "%~dp0"
	)
	echo.
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo Adding Tabs... 
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	cd C:\
	cd vivetool
	vivetool addconfig 34370472 2
	cd "%~dp0"
)

if "%1"=="taskmgr" (
	echo.
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo Adding Task Manager... 
	echo =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
	echo.
	cd C:\
	cd vivetool
	vivetool addconfig 35908098 2
	cd "%~dp0"
)

goto :eof

