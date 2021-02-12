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
echo 3.Shutdown Computer
echo 4.Restart Computer
echo 5.Add Startup Programs

choice /c 12345 /m "Choose a option:"

if %ERRORLEVEL%==1 (goto changebg)
if %ERRORLEVEL%==2 (goto themest)
if %ERRORLEVEL%==3 (goto shut)
if %ERRORLEVEL%==4 (goto shutres)
if %ERRORLEVEL%==5 (goto startadd)


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
	
:shut
choice /c YN /m "Do you want to force the shutdown(closes all programs without saving before shuting down):"
if %ERRORLEVEL%==1 (shutdown -s -f -t 0) else (shutdown -s -t 0)

:shutres
choice /c YN /m "Do you want to force the restart(closes all programs without saving before restarting):"
if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (shutdown -r -t 0)

:startadd
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
choice /c YN /m "Are themes allowed to change desktop items when applied? (Y/N)"

if %ERRORLEVEL%==1 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v ThemeChangesDesktopIcons /t REG_DWORD /d 1 /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v ThemeChangesDesktopIcons /t REG_DWORD /d 0 /f & goto menu1)

:themest_pointertoggle
choice /c YN /m "Are themes allowed to change the mouse pointer when applied? (Y/N)"

if %ERRORLEVEL%==1 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v ThemeChangesMousePointers /t REG_DWORD /d 1 /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes" /v ThemeChangesMousePointers /t REG_DWORD /d 0 /f & goto menu1)


