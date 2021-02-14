@echo off
cls
set %ERRORLEVEL%=0
:menu1
cls
cd "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
echo Welcome!
echo.
echo 1.Change Background
echo 2.Theme Settings
echo 3.Startup Settings
echo 4.Power Settings


choice /c 1234 /m "Choose a option:"

echo.
if %ERRORLEVEL%==1 (goto changebg)
if %ERRORLEVEL%==2 (goto themest)
if %ERRORLEVEL%==3 (goto startst)
if %ERRORLEVEL%==4 (goto powerst)




:changebg
set /p backprompt="Type the location of the file without the extension:"
if exist "%backprompt%".png (

	copy "%backprompt%".png "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper" > nul
	pause
	choice /c YN /m "You need to restart to apply the background, do you want to do it now?"
	if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (goto menu1)
	
	) else (
	
	echo Error:The file you specified does not exist.
	pause
	goto menu1
	
	)
	
:themest
cd "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Themes"
echo 1.Change Theme
echo 2.Toggle desktop icons changing by themes
echo 3.Toggle mouse pointer changing by themes
choice /c 123 /m "Choose a option:"

if %ERRORLEVEL%==1 (goto themest_change)
if %ERRORLEVEL%==2 (goto themest_deskicon)
if %ERRORLEVEL%==3 (goto themest_pointertoggle)

:themest_change
set /p themeprompt="Type the name of the theme without the location or extension:"

if exist "%themeprompt%".theme (

	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v CurrentTheme /t REG_SZ /d "C:\Users\%USERNAME%\AppData\Local\Microsoft\Windows\Themes\%themeprompt%.theme" /f
	pause
	choice /c YN /m "You need to restart to apply the theme, do you want to do it now?"
	if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (goto menu1)
	
	) else (
	
	echo Error:The file you specified does not exist.
	pause
	goto menu1
	
	)

:themest_deskicon
choice /c YN /m "Are themes allowed to change desktop items when applied?"

if %ERRORLEVEL%==1 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v ThemeChangesDesktopIcons /t REG_DWORD /d 1 /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v ThemeChangesDesktopIcons /t REG_DWORD /d 0 /f & goto menu1)

:themest_pointertoggle
choice /c YN /m "Are themes allowed to change the mouse pointer when applied?"

if %ERRORLEVEL%==1 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v ThemeChangesMousePointers /t REG_DWORD /d 1 /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v ThemeChangesMousePointers /t REG_DWORD /d 0 /f & goto menu1)

:startst
echo 1.Add Startup Programs
echo 2.Toogle Start Menu at Logon
echo 3.Set First Logon
choice /c 123 /m "Choose a option:"

if %ERRORLEVEL%==1 (goto startst_startadd)
if %ERRORLEVEL%==2 (goto startst_logonstm)
if %ERRORLEVEL%==3 (goto startst_firstlogon)

:startst_logonstm
choice /c YN /m "Will the start menu appear when you log in into Windows?"

if %ERRORLEVEL%==1 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartPage" /v OpenAtLogon /t REG_DWORD /d 1 /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartPage" /v OpenAtLogon /t REG_DWORD /d 0 /f & goto menu1)

:startst_startadd
set /p startprompt="Type the location of the file with the extension:"
if exist "%startprompt%" (
	
	copy "%startprompt%" "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup" > nul
	pause
	echo Done.
	goto menu1
	
) else (
	echo Error:The file you specified does not exist or it's in a different extension.
	pause
	goto menu1
)

:startst_firstlogon
choice /c YN /m "Do you want to redo your first logon(Make Windows reconfigure the user as it does in setup)?"

if %ERRORLEVEL%==1 (reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v FirstLogon /t REG_DWORD /d 1 /f)
if %ERRORLEVEL%==2 (reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v FirstLogon /t REG_DWORD /d 0 /f)
set %ERRORLEVEL%=0

choice /c YN /m "You need to restart to start the first boot, do you want to do it now?"
if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (goto menu1)

:powerst

echo 1.Shutdown Computer
echo 2.Restart Computer

choice /c 12 /m "Choose a option:"

if %ERRORLEVEL%==1 (goto powerst_shut)
if %ERRORLEVEL%==2 (goto powerst_shutres)

:powerst_shut
choice /c YN /m "Do you want to force the shutdown(closes all programs without saving before shuting down):"
if %ERRORLEVEL%==1 (shutdown -s -f -t 0) else (shutdown -s -t 0)

:powerst_shutres
choice /c YN /m "Do you want to force the restart(closes all programs without saving before restarting):"
if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (shutdown -r -t 0)
