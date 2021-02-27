@echo off
cls
set %ERRORLEVEL%=0

:menu1
cls
cd "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup"
echo Welcome!
echo.
echo 1.Desktop Settings
echo 2.Theme Settings
echo 3.Startup Settings
echo 4.Power Settings
echo 5.Mouse and Cursor Settings
echo 6.Start the Command Prompt
echo 7.Restart Explorer


choice /c 1234567 /m "Choose a option:"

echo.
if %ERRORLEVEL%==1 (goto deskst)
if %ERRORLEVEL%==2 (goto themest)
if %ERRORLEVEL%==3 (goto startst)
if %ERRORLEVEL%==4 (goto powerst)
if %ERRORLEVEL%==5 (goto cursorst)
if %ERRORLEVEL%==6 (start cmd.exe & goto menu1)
if %ERRORLEVEL%==7 (
	taskkill /f /im explorer.exe
	start explorer.exe
	goto menu1
)



:deskst
echo 1.Change Background
echo 2.Toggle Auto-Colorization

choice /c 12 /m "Choose a option:"

echo.
if %ERRORLEVEL%==1 (goto changebg)
if %ERRORLEVEL%==2 (goto autocol)

:changebg
set /p backprompt="Type the location of the file without the extension:"
if exist "%backprompt%".png (

	copy "%backprompt%".png "%AppData%\Microsoft\Windows\Themes\TranscodedWallpaper" > nul
	pause
	choice /c YN /m "You need to restart to apply the background, do you want to do it now?"
	if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (goto menu1)
	
	) else (
	
	echo Error:The file you specified does not exist.
	pause
	goto menu1
	
	)
	
:autocol
choice /c YN /m "Do you want to have auto-colorization enabled?"

if %ERRORLEVEL%==1 (reg add "HKCU\Control Panel\Desktop" /v AutoColorization /t REG_DWORD /d 1 /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\Control Panel\Desktop" /v AutoColorization /t REG_DWORD /d 0 /f & goto menu1)

	
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
	
	copy "%startprompt%" "%AppData%\Microsoft\Windows\Start Menu\Programs\Startup" > nul
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
echo 3.Clean Shutdown

choice /c 123 /m "Choose a option:"

if %ERRORLEVEL%==1 (goto powerst_shut)
if %ERRORLEVEL%==2 (goto powerst_shutres)
if %ERRORLEVEL%==2 (goto powerst_cleanshut)

:powerst_shut
choice /c YN /m "Do you want to force the shutdown(closes all programs without saving before shuting down):"
if %ERRORLEVEL%==1 (shutdown -s -f -t 0) else (shutdown -s -t 0)

:powerst_shutres
choice /c YN /m "Do you want to force the restart(closes all programs without saving before restarting):"
if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (shutdown -r -t 0)

:powerst_cleanshut
choice /c YN /m "Is Windows allowed to make a clean shutdown as the next shutdown?"

if %ERRORLEVEL%==1 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shutdown" /v CleanShutdown /t REG_DWORD /d 1 /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shutdown" /v CleanShutdown /t REG_DWORD /d 0 /f & goto menu1)

:cursorst
echo 1.Change Cursors
echo 2.Mouse Settings

choice /c 12 /m "Choose a option:"

if %ERRORLEVEL%==1 (goto cursorst_change)
if %ERRORLEVEL%==2 (goto cursorst_mousest)

:cursorst_change

echo 1.Standard(When not doing anything)
echo 2.Working(When loading something, like starting a app)
echo 3.Hand(When hovering over a link)

choice /c 123 /m "Choose a option:"

if %ERRORLEVEL%==1 (goto cursorst_change_sd)
if %ERRORLEVEL%==2 (goto cursorst_change_wk)
if %ERRORLEVEL%==3 (goto cursorst_change_hn)

:cursorst_change_sd

set /p cursorprompt="Type the full location of the cursor without the extension:"

if exist "%cursorprompt%".cur (

	reg add "HKCU\Control Panel\Cursors" /v Arrow /t REG_EXPAND_SZ /d "%cursorprompt%.cur" /f
	pause
	choice /c YN /m "You need to restart to apply the cursor, do you want to do it now?"
	if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (goto menu1)
	
	) else (
	
	echo Error:The file you specified does not exist.
	pause
	goto menu1
	
	)

:cursorst_change_wk

set /p cursorprompt="Type the full location of the cursor without the extension:"

if exist "%cursorprompt%".ani (

	reg add "HKCU\Control Panel\Cursors" /v Arrow /t REG_EXPAND_SZ /d "%cursorprompt%.ani" /f
	pause
	choice /c YN /m "You need to restart to apply the cursor, do you want to do it now?"
	if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (goto menu1)
	
	) else (
	
	echo Error:The file you specified does not exist.
	pause
	goto menu1
	
	)

:cursorst_change_hn

set /p cursorprompt="Type the full location of the cursor without the extension:"

if exist "%cursorprompt%".cur (

	reg add "HKCU\Control Panel\Cursors" /v Arrow /t REG_EXPAND_SZ /d "%cursorprompt%.cur" /f
	pause
	choice /c YN /m "You need to restart to apply the cursor, do you want to do it now?"
	if %ERRORLEVEL%==1 (shutdown -r -f -t 0) else (goto menu1)
	
	) else (
	
	echo Error:The file you specified does not exist.
	pause
	goto menu1
	
	)

:cursorst_mousest
echo 1.Toggle Extended Sounds
echo 2.Toggle Trails
echo 3.Toggle Button Swapping
echo 4.Toggle Beep
echo 5.Toggle Active Window Tracking
echo 6.Change Speed
echo 7.Change Sensibility
echo 8.Change Hover Time
echo 9.Change Double-click Speed

choice /c 123456789 /m "Choose a option:"

if %ERRORLEVEL%==1 (goto cursorst_mousest_exts)
if %ERRORLEVEL%==2 (goto cursorst_mousest_trails)
if %ERRORLEVEL%==3 (goto cursorst_mousest_butswap)
if %ERRORLEVEL%==4 (goto cursorst_mousest_beep)
if %ERRORLEVEL%==5 (goto cursorst_mousest_actwintrack)
if %ERRORLEVEL%==6 (goto cursorst_mousest_speed)
if %ERRORLEVEL%==7 (goto cursorst_mousest_sens)
if %ERRORLEVEL%==8 (goto cursorst_mousest_hovertime)
if %ERRORLEVEL%==9 (goto cursorst_mousest_doubleclickspeed)

:cursorst_mousest_exts

choice /c YN /m "Do you want to hear extended sounds when using the mouse?"

if %ERRORLEVEL%==1 (reg add "HKCU\Control Panel\Mouse" /v ExtendedSounds /t REG_SZ /d Yes /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\Control Panel\Mouse" /v ExtendedSounds /t REG_SZ /d No /f & goto menu1)

:cursorst_mousest_trails

choice /c YN /m "Do you want to have the mouse animations cause trails?"

if %ERRORLEVEL%==1 (reg add "HKCU\Control Panel\Mouse" /v MouseTrails /t REG_SZ /d 1 /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\Control Panel\Mouse" /v MouseTrails /t REG_SZ /d 0 /f & goto menu1)

:cursorst_mousest_butswap

choice /c YN /m "Do you want to have the mouse buttons swapped?"

if %ERRORLEVEL%==1 (reg add "HKCU\Control Panel\Mouse" /v SwapMouseButtons /t REG_SZ /d 1 /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\Control Panel\Mouse" /v SwapMouseButtons /t REG_SZ /d 0 /f & goto menu1)

:cursorst_mousest_beep

choice /c YN /m "Do you want the mouse to make a beep sound?"

if %ERRORLEVEL%==1 (reg add "HKCU\Control Panel\Mouse" /v Beep /t REG_SZ /d Yes /f & goto menu1)
if %ERRORLEVEL%==2 (reg add "HKCU\Control Panel\Mouse" /v Beep /t REG_SZ /d No /f & goto menu1)

:cursorst_mousest_actwintrack

choice /c YN /m "Do you want to activate Window Tracking?"

if %ERRORLEVEL%==1 (
	reg add "HKCU\Control Panel\Mouse" /v ActiveWindowTracking /t REG_SZ /d 1 /f
	reg add "HKCU\Control Panel\Desktop" /v ActiveWndTrackTimeout /t REG_SZ /d 1 /f
	goto menu1
)
if %ERRORLEVEL%==2 (
	reg add "HKCU\Control Panel\Mouse" /v ActiveWindowTracking /t REG_SZ /d 0 /f
	reg add "HKCU\Control Panel\Desktop" /v ActiveWndTrackTimeout /t REG_SZ /d 0 /f
	goto menu1
)

:cursorst_mousest_speed

set /p mouseprompt="Type how much speed do you want in the mouse as a number(The default is 1):"

reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d %mouseprompt% /f
goto menu1

:cursorst_mousest_sens

set /p mouseprompt="Type how much sensitivity do you want in the mouse as a number(The default is 10):"

reg add "HKCU\Control Panel\Mouse" /v MouseSensitivity /t REG_SZ /d %mouseprompt% /f
goto menu1

:cursorst_mousest_hovertime

set /p mouseprompt="Type how much hover time do you want in the mouse as a number(The default is 400):"

reg add "HKCU\Control Panel\Mouse" /v MouseHoverTime /t REG_SZ /d %mouseprompt% /f
goto menu1

:cursorst_mousest_doubleclickspeed

set /p mouseprompt="Type how much double click speed do you want in the mouse as a number(The default is 500):"

reg add "HKCU\Control Panel\Mouse" /v DoubleClickSpeed /t REG_SZ /d %mouseprompt% /f
goto menu1