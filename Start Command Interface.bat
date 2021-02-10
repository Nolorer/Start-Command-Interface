@echo off
cls
set %ERRORLEVEL%=0
:menu1
cls
echo Welcome!
echo.
echo 1.Change Background
echo 2.Shutdown Computer
echo 3.Restart Computer
echo 4.Add Startup Programs

choice /c 1234 /m "Choose a option:"

if %ERRORLEVEL%==1 (goto changebg)
if %ERRORLEVEL%==2 (goto shut)
if %ERRORLEVEL%==3 (goto shutres)
if %ERRORLEVEL%==4 (goto startadd)


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

