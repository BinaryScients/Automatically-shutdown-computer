:: Author: Willian Azevedo 
:: Created on: 11th, October, 2020 at 01:15 P.M. (GMT-3) 
:: Last Modification on: 18th, October, 2020 at 01:12 P.M. (GMT-3) 
:: Sleeping Aid - Automatic shutdown program version 0.1.35 Alpha 
:: 
:: This is a simple batch program for automatically shutdown pc

::TODO
:: Implement an option that verify if already has a task schedule [-] (in progress) -> FIX THE BUGS, RESTRUCT ALL THE LOGIC
:: Change the rix and the six permitions
:: Create a Help Menu
:: Fix the menus of the pc shutdown [-] (in progress)
@echo off
SETLOCAL DISABLEDELAYEDEXPANSION

:load
set accpathxcbd="data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}"
echo Loading...
if not exist data (
	md data
	echo 0a >data\theme.dat
	md %accpathxcbd%
	attrib +h +s %accpathxcbd%
	echo "0">"%accpathxcbd%\six.dat"
	echo "0">"%accpathxcbd%\rix.dat"
)
if not exist %accpathxcbd% (
	md %accpathxcbd%
	attrib +h +s %accpathxcbd%
	echo "0">"%accpathxcbd%\six.dat"
	echo "0">"%accpathxcbd%\rix.dat"
)
if not exist "data\theme.dat" echo 0a >data\theme.dat
set /p shutx=<%accpathxcbd%\six.dat
set /p restx=<%accpathxcbd%\rix.dat
set /p themec=<data\theme.dat

:start
color %themec%
mode 90, 30
title Sleeping aid - Automatic shutdown program (v0.1.35 alpha)
cls

:main
echo Sleeping Aid - Automatic Shutdown Program for Windows
echo version 0.1.35 Alpha
echo.
echo        _    _  ____  __    ___  _____  __  __  ____ 
echo       ( \/\/ )( ___)(  )  / __)(  _  )(  \/  )( ___)
echo        )    (  )__)  )(__( (__  )(_)(  )    (  )__) 
echo       (__/\__)(____)(____)\___)(_____)(_/\/\_)(____)
echo               _________
echo              (_____    )
echo                   )   /_______
echo                  /   /____    )
echo                 /   /    )   /
echo                /   (____/   /
echo               (__________) (_____
echo                       (__________)
echo.
echo What you want to do now?
echo.
echo.
echo 1) Shutdown the pc now
echo 2) Schedule the pc to shutdown
echo 3) Schedule the pc to restart
echo 4) Delete schedule
echo 5) Go to options
echo 6) Help
echo     0) exit
echo.
set /p res="Type the number of the option that you want: "

if "%res%" == "1" cls&goto turnoff
if "%res%" == "2" cls&goto schedule1
if "%res%" == "3" cls&goto schedule2
if "%res%" == "4" cls&goto deletesch
if "%res%" == "5" cls&goto options
if "%res%" == "6" cls&goto help
if "%res%" == "0" cls&goto finish

color 0c
echo Error, the command "%res%" wasn't recognized
echo.
echo        [PRESS ENTER TYPE AGAIN]
pause>nul
color %themec%
cls&goto main

:turnoff
echo.
echo The pc will shutdown now
echo.
echo        [PRESS ENTER TO CONFIRM]
echo.
pause>nul
shutdown /s /f
echo turning off the PC...
ping 127.0.0.1 -n 1 >nul
cls&goto finish

:schedule1
echo Schedule the pc to shutdown
echo.
set /p tm="Enter the time (24h base time HH:MM) that you want the pc to turn off: "
if "%ERRORLEVEL%" NEQ "0" (
	color 0c
	echo Error, the command "%sc%" wasn't recognized
	echo.
	echo        [PRESS ENTER TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule1
)
echo.
set /p dt="Enter the date (DD/MM/YYYY) you want this rule to start taking effect (by default it's considered today, type today for default option): "
if "%ERRORLEVEL%" NEQ "0" (
	color 0c
	echo Error, the command "%dt%" wasn't recognized
	echo.
	echo        [PRESS ENTER TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule1
)
if "%dt%" == "today" set dt=%DATE%
echo What frequency do you want it to turn off?
echo.
echo 1) Once
echo 2) Minute
echo 3) Hourly
echo 4) Daily
echo 5) Weekly
echo 6) Monthly
echo.
set /p frec="Type here: "

if "%frec%" == "1" (
	set frec=ONCE
) else if "%frec%" == "2" (
	set frec=MINUTE
) else if "%frec%" == "3" (
	set frec=HOURLY
) else if "%frec%" == "4" (
	set frec=DAILY
) else if "%frec%" == "5" (
	set frec=WEEKLY
) else if "%frec%" == "6" (
	set frec=MONTHLY
) else (
	color 0c
	echo.
	echo Error, the command "%frec%" is invalid!
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule1
)

echo.
echo Verifing...
if not exist "%accpathxcbd%\PCSHUTDOWN%shutx%" goto apply_schedule1

:verify_schedule1
echo There is already an appointment, do you want to overwrite it
echo.
echo 1) Yes
echo 2) No
echo     0) Cancel
echo.
set /p res="Type here: "

if "%res%" == "1" (
		goto apply_schedule1
) else if "%res%" == "2" (
	goto new_schedule1
) else if "%res%" == "0" (
	cls&goto main
) else (
	color 0c
	echo.
	echo Error, the command "%res%" is invalid!
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule1
)

:new_schedule1
echo.
echo An other schedule will be created
echo.
echo        [PRESS ENTER TO CONTINUE]
pause>nul
echo.
set /a t=1+%shutx% >nul
if "%t%" GTR "4" (
	echo.
	echo ERROR, the limit of schedules for shutdown is only 5
	echo.
	echo [POSSIBLE SOLUTIONS]:
	echo -You can overwrite an existing schedule
	echo -Or you can delete an existing schedule by going to the Main menu } Delete schedule
	echo.
	echo         [PRESS ENTER TO GO TO MENU]
	echo.
	pause>nul
	cls&goto main
)
set /a shutx="%t%" + "0" >nul
echo "%t%">"%accpathxcbd%\six.dat"

:apply_schedule1
echo Applying settings...
schtasks /create /sc %frec% /tn PCSHUTDOWN%shutx% /tr "shutdown /s" /st %tm% /sd %dt%
if "%ERRORLEVEL%" NEQ "0" (
	color 0c
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule1
)
set /a new=%shutx% + 0
echo : %new% NAME:PCSHUTDOWN%new% DATE:%dt% TIME:%tm% FREQUENCY:%frec%>"data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCSHUTDOWN%shutx%"
echo.
echo SUCCESS: The computer has been programmed to shutdown on %dt% at %tm% %frec% successfully
echo.
echo         [PRESS ENTER TO GO TO MENU]
echo.
pause>nul
cls&goto main

:schedule2
echo Schedule the pc to restart
echo.
set /p tm="Enter the time (24h base time HH:MM) that you want the pc to restart: "
if "%ERRORLEVEL%" NEQ "0" (
	color 0c
	echo Error, the command "%sc%" wasn't recognized
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule2
)
echo.
set /p dt="Enter the date (DD/MM/YYYY) you want this rule to start taking effect (by default it's considered today, type today for default option): "
if "%ERRORLEVEL%" NEQ "0" (
	color 0c
	echo Error, the command "%dt%" wasn't recognized
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule2
)
if "%dt%" == "today" set dt=%DATE%
echo What frequency do you want it to restart?
echo.
echo 1) Once
echo 2) Minute
echo 3) Hourly
echo 4) Daily
echo 5) Weekly
echo 6) Monthly
echo.
set /p frec="Type here: "

if "%frec%" == "1" (
	set frec=ONCE
) else if "%frec%" == "2" (
	set frec=MINUTE
) else if "%frec%" == "3" (
	set frec=HOURLY
) else if "%frec%" == "4" (
	set frec=DAILY
) else if "%frec%" == "5" (
	set frec=WEEKLY
) else if "%frec%" == "6" (
	set frec=MONTHLY
) else (
	color 0c
	echo.
	echo Error, the command "%frec%" is invalid!
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule2
)

echo.
echo Verifing...
if not exist %accpathxcbd%\PCRESTART%restx% goto apply_schedule2

:verify_schedule2
echo There is already an appointment, do you want to overwrite it?
echo.
echo 1) Yes
echo 2) No
echo     0) Cancel
echo.
set /p res="Type here: "

if "%res%" == "1" (
	goto apply_schedule2
) else if "%res%" == "2" (
	goto new_schedule2
) else if "%res%" == "0" (
	cls&goto main
) else (
	color 0c
	echo.
	echo Error, the command "%res%" is invalid!
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule2
)


:new_schedule2
echo.
echo An other schedule will be created
echo.
echo        [PRESS ENTER TO CONTINUE]
echo.
pause>nul
set /a t=1+%restx% >nul
if "%t%" GTR "4" (
	echo.
	echo ERROR, the limit of schedules for restart is only 5
	echo.
	echo [POSSIBLE SOLUTIONS]:
	echo -You can overwrite an existing schedule
	echo -Or you can delete an existing schedule by going to the Main menu } Delete schedule
	echo.
	echo         [PRESS ENTER TO GO TO MENU]
	echo.
	pause>nul
	cls&goto main
)
set /a restx="%t%" + "0" >nul
echo "%t%">%accpathxcbd%\rix.dat"

:apply_schedule2
echo Applying settings...
schtasks /create /sc %frec% /tn PCRESTART%restx% /tr "shutdown /r" /st %tm% /sd %dt%
if "%ERRORLEVEL%" NEQ "0" (
	color 0c
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule2
)
set /a fow=%restx% + 0
set /a new=%restx% + 5
echo : %new% NAME:PCRESTART%fow% DATE:%dt% TIME:%tm% FREQUENCY:%frec%>%accpathxcbd%\PCRESTART%restx%
echo.
echo SUCCESS: The computer has been programmed to restart on %dt% at %tm% %frec% successfully
echo.
echo         [PRESS ENTER TO GO TO MENU]
echo.
pause>nul
cls&goto main

:deletesch
echo Delete a schedule
echo.
echo.
echo Choose what schedule you want to delete:

if not exist %accpathxcbd%\six.dat (
	color c4
	echo.
	echo FATAL ERROR
	echo.
	echo DATABASE_ERROR: -227704
	echo.
	echo Can't localize primary schedule
	echo.
	echo [POSSIBLE SOLUTION]:
	echo GO TO OPTIONS } CLEAN ALL THE SCHEDULES } CONFIRM
	echo         [PRESS ENTER TO GO TO MENU]
	echo.
	pause>nul
	color %themec%
	cls&goto main
)
if not exist %accpathxcbd%\rix.dat (
	color c4
	echo.
	echo FATAL ERROR
	echo.
	echo DATABASE_ERROR: -227705
	echo.
	echo Can't localize primary schedule
	echo.
	echo [POSSIBLE SOLUTION]:
	echo GO TO OPTIONS } CLEAN ALL THE SCHEDULES } CONFIRM
	echo         [PRESS ENTER TO GO TO MENU]
	echo.
	pause>nul
	color %themec%
	cls&goto main
)
set slots=0
echo  ____  ____  __    ____  ____  ____ 
echo (  _ \( ___)(  )  ( ___)(_  _)( ___)                          .-----.
echo  )(_) ))__)  )(__  )__)   )(   )__)                          / _   _ \
echo (____/(____)(____)(____) (__) (____)                         ](_' `_)[
echo           ___   ___  _   _  ____  ____  __  __  __    ____   `-. M ,-' 
echo          / __) / __)( )_( )( ___)(  _ \(  )(  )(  )  ( ___)    ]"""[
echo          \__ \( (__  ) _ (  )__)  )(_) ))(__)(  )(__  )__)     `---'
echo          (___/ \___)(_) (_)(____)(____/(______)(____)(____)
echo.
echo ==================================================================
echo    PC SHUTDOWN SCHEDULES:
echo.
if exist "%accpathxcbd%\PCSHUTDOWN0" (
	type "%accpathxcbd%\PCSHUTDOWN0"
	set slot0=True
) else (
	echo : -------------------------------------------------
	set slot0=False
	set /a slots="%slots%+1"
)

if exist "%accpathxcbd%\PCSHUTDOWN1" (
	type "%accpathxcbd%\PCSHUTDOWN1"
	set slot1=True
) else (
	echo : -------------------------------------------------
	set slot1=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCSHUTDOWN2" (
	type "%accpathxcbd%\PCSHUTDOWN2"
	set slot2=True
) else (
	echo : -------------------------------------------------
	set slot2=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCSHUTDOWN3" (
	type "%accpathxcbd%\PCSHUTDOWN3"
	set slot3=True
) else (
	echo : -------------------------------------------------
	set slot3=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCSHUTDOWN4" (
	type "%accpathxcbd%\PCSHUTDOWN4"
	set slot4=True
) else (
	echo : -------------------------------------------------
	set slot4=False
	set /a slots="%slots%+1"
)

echo.
echo    PC RESTART SCHEDULES:
echo.

if exist "%accpathxcbd%\PCRESTART0" (
	type "%accpathxcbd%\PCRESTART0"
	set slot5=True
) else (
	echo : -------------------------------------------------
	set slot5=False
	set /a slots="%slots%+1"
)

if exist "%accpathxcbd%\PCRESTART1" (
	type "%accpathxcbd%\PCRESTART1"
	set slot6=True
) else (
	echo : -------------------------------------------------
	set slot6=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCRESTART2" (
	type "%accpathxcbd%\PCRESTART2"
	set slot7=True
) else (
	echo : -------------------------------------------------
	set slot7=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCRESTART3" (
	type "%accpathxcbd%\PCRESTART3"
	set slot8=True
) else (
	echo : -------------------------------------------------
	set slot8=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCRESTART4" (
	type "%accpathxcbd%\PCRESTART4"
	set slot9=True
) else (
	echo : -------------------------------------------------
	set slot9=False
	set /a slots="%slots%+1"
)

if "%slots%" == "10" goto empty

echo.
echo Type 'cancel' or 'x' to cancel operation...
echo.
set /p opt="Enter the number of the schedule that you want to delete: "

if "%opt%" == "0" (
	if "%slot0%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "1" (
	if "%slot1%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "2" (
	if "%slot2%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "3" (
	if "%slot3%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "4" (
	if "%slot4%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "5" (
	if "%slot5%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "6" (
	if "%slot6%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "7" (
	if "%slot7%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "8" (
	if "%slot8%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "9" (
	if "%slot9%" == "True" (
		goto apply_deletion
	) else (
		color 0c
		echo Invalid option! Type the NUMBER of the SCHEDULE that
		echo You want to DELETE
		echo.
		echo        [PRESS ENTER TO TYPE AGAIN]
		pause>nul
		color %themec%
		cls&goto deletesch
	)
) else if "%opt%" == "cancel" (
	echo Operation canceled!
	echo.
	echo        [PRESS ENTER TO GO TO MENU]
	pause>nul
	cls&goto main
) else if "%opt%" == "x" (
	echo Operation canceled!
	echo.
	echo        [PRESS ENTER TO GO TO MENU]
	pause>nul
	cls&goto main

)else if "%opt%" == "CANCEL" (
	echo Operation canceled!
	echo.
	echo        [PRESS ENTER TO GO TO MENU]
	pause>nul
	cls&goto main
) else if "%opt%" == "X" (
	echo.
	echo Operation canceled!
	echo.
	echo        [PRESS ENTER TO GO TO MENU]
	pause>nul
	cls&goto main
) else (
	color 0c
	echo Invalid option! Type the NUMBER of the SCHEDULE that
	echo You want to DELETE
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto deletesch
)

:apply_deletion
if "%opt%" LSS "5" (
	set stak=PCSHUTDOWN
) else (
	set stak=PCRESTART
	set /a opt="%opt%-5"
)

set /p confirm="Are you sure you want to delete %stak%%opt% schedule? (Y\N): "
if "%confirm%" == "Y" (
	echo Deleting the schedule...
) else if "%confirm%" == "y" (
	echo Deleting the schedule...
) else if "%confirm%" == "N" (
	echo.
	echo Operation canceled!
	echo.
	echo        [PRESS ENTER TO GO TO MENU]
	pause>nul
	cls&goto main
) else if "%confirm%" == "n" (
	echo.
	echo Operation canceled!
	echo.
	echo        [PRESS ENTER TO GO TO MENU]
	pause>nul
	cls&goto main
) else (
	color 0c
	echo.
	echo Invalid option, just enter "Y" [YES] or "N" [NO]
	echo To confirm or not the exclusion
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto apply_deletion
)

schtasks /delete /f /tn "%stak%%opt%"
if "%ERRORLEVEL%" GTR "0" (
	color 0c
	echo An error ocurred, try again later
	echo.
	echo        [PRESS ENTER TO GO TO MENU]
	pause>nul
	color %themec%
	cls&goto main
)
del "%accpathxcbd%\%stak%%opt%"
if "%ERRORLEVEL%" GTR "0" (
	color 0c
	echo An error ocurred, try again later
	echo.
	echo        [PRESS ENTER TO GO TO MENU]
	pause>nul
	color %themec%
	cls&goto main
)

if "%stak%" == "PCSHUTDOWN" goto ver1
if "%stak%" == "PCRESTART" goto ver2

:ver1
if %shutx% == "0" goto deletefinish
goto reduceshutx

:ver2
if %restx% == "0" goto deletefinish
goto reducerestx

:reduceshutx
set /a t="%shutx%-1"
set shutx="%t%"
echo %shutx%>"%accpathxcbd%\six.dat"
goto deletefinish

:reducerestx
set /a t="%restx%-1"
set restx="%t%"
echo %restx%>"%accpathxcbd%\rix.dat"
goto deletefinish

:deletefinish
echo SUCCESS: The schedule %stak%%opt% has been deleted successfully!
echo.
echo        [PRESS ENTER TO GO TO MENU]
pause>nul
cls&goto main

:empty
echo.
echo No schedules to show
echo.
echo         [PRESS ENTER TO GO TO MENU]
echo.
pause>nul
cls&goto main

:options
echo Options Menu
echo.
echo What you want?
echo.
echo 1) Change colors theme
echo 2) Clean all the schedules
echo     0) Go back
echo.
set /p var="Type here: "
echo.
if "%var%" == "1" goto colortheme
if "%var%" == "2" goto clean
if "%var%" == "0" cls&goto main

color 0c
echo Error, the command "%var%" wasn't recognized
echo.
echo        [PRESS ENTER TO TYPE AGAIN]
pause>nul
color %themec%
cls&goto options

:colortheme
cls
echo     ##############################################################################
echo     # " _____  _____  ____   _____  _____    ____  __ __  _____  __  __  _____ " #
echo     # "/     \/  _  \/  _/  /  _  \/  _  \  /    \/  |  \/   __\/  \/  \/   __\" #
echo     # "|  |--||  |  ||  |---|  |  ||  _  <  \-  -/|  _  ||   __||  \/  ||   __|" #
echo     # "\_____/\_____/\_____/\_____/\__|\_/   |__| \__|__/\_____/\__ \__/\_____/" #
echo     # "                                                                        " #
echo     ##############################################################################
echo.
echo Choose a theme
echo.
echo 1) White Whale
echo 2) Black horizon
echo 3) Good vibes
echo 4) Elecktro shock
echo 5) PinKY
echo 6) Sky Bloom
echo 7) Green hills
echo 8) Elegant
echo 9) Contrast
echo     0) Go back
echo.
set /p var="which you want: "
if "%var%" == "1" (
	set themec=f1
	color f1
	cls&goto colortheme
)
if "%var%" == "2" (
	set themec=0a
	color 0a
	cls&goto colortheme
)

if "%var%" == "3" (
	set themec=e8
	color e8
	cls&goto colortheme
	
)
if "%var%" == "4" (
	set themec=10
	color 10
	cls&goto colortheme
	
)
if "%var%" == "5" (
	set themec=56
	color 56
	cls&goto colortheme
	
)
if "%var%" == "6" (
	set themec=9f
	color 9f
	cls&goto colortheme
	
)
if "%var%" == "7" (
	set themec=ae
	color ae
	cls&goto colortheme
	
)
if "%var%" == "8" (
	set themec=87
	color 87
	cls&goto colortheme
	
)
if "%var%" == "9" (
	set themec=0f
	color 0f
	cls&goto colortheme
	
)

if "%var%" == "0" (
	echo %themec%>data\theme.dat
	cls&goto options
)

color 0c
echo Error, the command "%var%" wasn't recognized
echo.
echo        [PRESS ENTER TO TYPE AGAIN]
pause>nul
color %themec%
cls&goto colortheme

:clean
echo Cleaning...
schtasks /delete /f /tn "PCSHUTDOWN0"
schtasks /delete /f /tn "PCSHUTDOWN1"
schtasks /delete /f /tn "PCSHUTDOWN2"
schtasks /delete /f /tn "PCSHUTDOWN3"
schtasks /delete /f /tn "PCSHUTDOWN4"
schtasks /delete /f /tn "PCRESTART0"
schtasks /delete /f /tn "PCRESTART1"
schtasks /delete /f /tn "PCRESTART2"
schtasks /delete /f /tn "PCRESTART3"
schtasks /delete /f /tn "PCRESTART4"
rd /s /q %accpathxcbd%
cls
echo DONE, ALL SCHEDULES WERE REMOVED
echo.
echo.
echo        [PRESS ENTER TO GO TO MENU]
pause>nul
cls&goto main

:help
echo  Hi,
echo  This is a guide to help you schedule your tasks smoothly.
echo.
echo  You may have noticed that there are many options in the menu, including the help option 
echo  (this one), so if you want to schedule a shutdown, you type in the option number and 
echo  follow the steps that the 
echo  menu will give you.
echo.
echo  If you didn't like these colors displayed at the prompt, you can change them through the 
echo  options and then the color theme option.
echo.
echo  If you want to delete all of the schedules at once, or you are unable to delete the 
echo  schedules, and if they are causing you troubles, you can go to the clean option, 
echo  which is found in the options menu, along with the color theme options.
echo.
echo.
echo      OBSERVATIONS:
echo.
echo This page is a draft, this text is subject to change. 
echo It is possible that there will be improvements in a short time.
echo.
echo        [PRESS ENTER TO GO TO MENU]
pause>nul
cls&goto main

:finish
echo %themec%>data\theme.dat
exit
