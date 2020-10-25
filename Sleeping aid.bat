:: Author: Willian Azevedo 
:: Created on: 11th, October, 2020 at 01:15 P.M. (GMT-3) 
:: Last Modification on: 25th, October, 2020 at 04:20 P.M. (GMT-3) 
:: Sleeping Aid - Automatic shutdown program version 0.2.0 Beta
:: 
:: This is a simple batch program for automatically shutdown pc
::
::
:: Sleeping Aid is free software: you can redistribute it and/or modify
:: it under the terms of MIT License.


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
	echo "0">"%accpathxcbd%\sqt.dat"
	echo "0">"%accpathxcbd%\rqt.dat"
)
if not exist %accpathxcbd% (
	md %accpathxcbd%
	attrib +h +s %accpathxcbd%
	echo "0">"%accpathxcbd%\sqt.dat"
	echo "0">"%accpathxcbd%\rqt.dat"
)
if not exist "data\theme.dat" echo 0a >data\theme.dat
set /p shutq=<%accpathxcbd%\sqt.dat
set /p restq=<%accpathxcbd%\rqt.dat
set /p themec=<data\theme.dat
set shutx="0"
set restx="0"

:start
color %themec%
mode 100, 30
title Sleeping aid - Automatic shutdown program (v0.2 beta)
cls

:main
echo Sleeping Aid - Automatic Shutdown Program for Windows
echo version 0.2.0 Beta
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
echo   What you want to do?
echo.
echo.
echo  1) Shutdown the pc now
echo  2) Schedule the pc to shutdown
echo  3) Schedule the pc to restart
echo  4) Delete schedule
echo  5) Go to options
echo  6) Help
echo  7) About
echo      0) exit
echo.
set /p res="Type the number of the option that you want: "

if "%res%" == "1" cls&goto turnoff
if "%res%" == "2" cls&goto schedule1
if "%res%" == "3" cls&goto schedule2
if "%res%" == "4" cls&goto deletesch
if "%res%" == "5" cls&goto options
if "%res%" == "6" cls&goto help
if "%res%" == "7" cls&goto about
if "%res%" == "0" cls&goto finish

color 0c
echo Error, the command "%res%" wasn't recognized
echo.
echo        [PRESS ENTER TO TYPE AGAIN]
pause>nul
color %themec%
cls&goto main

:turnoff
echo.
echo  The pc will shutdown now
echo.
echo         [PRESS ENTER TO CONFIRM]
echo.
pause>nul
shutdown /s /f
echo turning off the PC...
ping 127.0.0.1 -n 1 >nul
cls&goto finish

:schedule1
echo SCHEDULE THE PC TO SHUTDOWN
echo.
set /p tm="  Enter the time (24h base time HH:MM) that you want the pc to turn off: "
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
set /p dt="  Enter the date (DD/MM/YYYY) you want this rule to start taking effect (by default it's considered today, type today for default option): "
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
echo   What frequency do you want it to turn off?
echo.
echo  1) Once
echo  2) Minute
echo  3) Hourly
echo  4) Daily
echo  5) Weekly
echo  6) Monthly
echo.
set /p frec="  Type here: "

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
::if not exist "%accpathxcbd%\PCSHUTDOWN%shutx%" goto apply_schedule1

:verify_schedule1
set slots=0
set opt=none
set new=none
cls
echo    PC SHUTDOWN SCHEDULES:
echo.
if exist "%accpathxcbd%\PCSHUTDOWN0" (
	type "%accpathxcbd%\PCSHUTDOWN0"
	set slot0=True
) else (
	echo : 0 ------------------------------------------------------------------
	set slot0=False
	set /a slots="%slots%+1"
)

if exist "%accpathxcbd%\PCSHUTDOWN1" (
	type "%accpathxcbd%\PCSHUTDOWN1"
	set slot1=True
) else (
	echo : 1 ------------------------------------------------------------------
	set slot1=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCSHUTDOWN2" (
	type "%accpathxcbd%\PCSHUTDOWN2"
	set slot2=True
) else (
	echo : 2 ------------------------------------------------------------------
	set slot2=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCSHUTDOWN3" (
	type "%accpathxcbd%\PCSHUTDOWN3"
	set slot3=True
) else (
	echo : 3 ------------------------------------------------------------------
	set slot3=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCSHUTDOWN4" (
	type "%accpathxcbd%\PCSHUTDOWN4"
	set slot4=True
) else (
	echo : 4 ------------------------------------------------------------------
	set slot4=False
	set /a slots="%slots%+1"
)


echo.
if %shutq% GTR "5" (
	echo  All the slots are full
	echo  Choose any to replace
	echo  Or quit to delete
) else if %shutq% EQU "0" (
	echo  All the slots are empty
	echo  Choose any slot to save your first schedule
) else if %shutq% LSS "5" (
	echo  Which slot you want to save the schedule?
	echo  If you choose an existing schedule, it will be replaced
)
echo.
echo  Type 'cancel' or 'x' to cancel operation...
echo.
set /p opt=" Enter the number of the slot that you want to save/change: "

if "%opt%" == "0" (
	if "%slot0%" == "False" (
		set shutx="%opt%"
		set new=True
		goto apply_schedule1
	) else (
		color 0c
		set shutx="%opt%"
		goto apply_schedule1
	)
) else if "%opt%" == "1" (
	if "%slot1%" == "False" (
		set shutx="%opt%"
		set new=True
		goto apply_schedule1
	) else (
		set shutx="%opt%"
		goto apply_schedule1
	)
) else if "%opt%" == "2" (
	if "%slot2%" == "False" (
		set shutx="%opt%"
		set new=True
		goto apply_schedule1
	) else (
		set shutx="%opt%"
		goto apply_schedule1
	)
) else if "%opt%" == "3" (
	if "%slot3%" == "False" (
		set shutx="%opt%"
		set new=True
		goto apply_schedule1
	) else (
		set shutx="%opt%"
		goto apply_schedule1
	)
) else if "%opt%" == "4" (
	if "%slot4%" == "False" (
		set shutx="%opt%"
		set new=True
		goto apply_schedule1
	) else (
		set shutx="%opt%"
		goto apply_schedule1
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

) else if "%opt%" == "CANCEL" (
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
	echo Invalid option! Type the NUMBER of the SLOT that
	echo You want to SAVE or CHANGE
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto verify_schedule1
)

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
if "%new%" == "True" set /a shutq="1 + %shutq%"
set /a new=%shutx% + 0
echo : %new% NAME:PCSHUTDOWN%new% DATE:%dt% TIME:%tm% FREQUENCY:%frec%>"%accpathxcbd%\PCSHUTDOWN%shutx%"
echo "%shutq%">%accpathxcbd%\sqt.dat
echo.
echo The computer has been programmed to shutdown on %dt% at %tm% %frec%
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
::if not exist %accpathxcbd%\PCRESTART%restx% goto apply_schedule2
:verify_schedule2
set slots=0
set opt=none
set new=none
cls
echo    PC RESTART SCHEDULES:
echo.
if exist "%accpathxcbd%\PCRESTART0" (
	type "%accpathxcbd%\PCRESTART0"
	set slot5=True
) else (
	echo : 5 ------------------------------------------------------------------
	set slot5=False
	set /a slots="%slots%+1"
)

if exist "%accpathxcbd%\PCRESTART1" (
	type "%accpathxcbd%\PCRESTART1"
	set slot6=True
) else (
	echo : 6 ------------------------------------------------------------------
	set slot6=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCRESTART2" (
	type "%accpathxcbd%\PCRESTART2"
	set slot7=True
) else (
	echo : 7 ------------------------------------------------------------------
	set slot7=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCRESTART3" (
	type "%accpathxcbd%\PCRESTART3"
	set slot8=True
) else (
	echo : 8 ------------------------------------------------------------------
	set slot8=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCRESTART4" (
	type "%accpathxcbd%\PCRESTART4"
	set slot9=True
) else (
	echo : 9 ------------------------------------------------------------------
	set slot9=False
	set /a slots="%slots%+1"
)


echo.
if %restq% GTR "5" (
	echo  All the slots are full
	echo  Choose any to replace
	echo  Or quit to delete
) else if %restq% EQU "0" (
	echo  All the slots are empty
	echo  Choose any slot to save your first schedule
) else if %restq% LEQ "4" (
	echo  Which slot you want to save the schedule?
	echo  If you choose an existing schedule, it will be replaced
)
echo.
echo  Type 'cancel' or 'x' to cancel operation...
echo.
set /p opt=" Enter the number of the slot that you want to save/change: "

if "%opt%" == "5" (
	if "%slot5%" == "False" (
		set /a restx=%opt%-5
		set new=True
		goto apply_schedule2
	) else (
		color 0c
		set /a restx=%opt%-5
		goto apply_schedule2
	)
) else if "%opt%" == "6" (
	if "%slot6%" == "False" (
		set /a restx=%opt%-5
		set new=True
		goto apply_schedule2
	) else (
		set /a restx=%opt%-5
		goto apply_schedule2
	)
) else if "%opt%" == "7" (
	if "%slot7%" == "False" (
		set /a restx=%opt%-5
		set new=True
		goto apply_schedule2
	) else (
		set /a restx=%opt%-5
		goto apply_schedule2
	)
) else if "%opt%" == "8" (
	if "%slot8%" == "False" (
		set /a restx=%opt%-5
		set new=True
		goto apply_schedule2
	) else (
		set /a restx=%opt%-5
		goto apply_schedule2
	)
) else if "%opt%" == "9" (
	if "%slot9%" == "False" (
		set /a restx=%opt%-5
		set new=True
		goto apply_schedule2
	) else (
		set /a restx=%opt%-5
		goto apply_schedule2
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

) else if "%opt%" == "CANCEL" (
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
	echo Invalid option! Type the NUMBER of the SLOT that
	echo You want to SAVE or CHANGE
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto verify_schedule2
)

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
if "%new%" == "True" set /a restq="1 + %restq%"
set /a new=%restx% + 5
echo : %new% NAME:PCRESTART%restx% DATE:%dt% TIME:%tm% FREQUENCY:%frec%>"%accpathxcbd%\PCRESTART%restx%"
echo "%restq%">%accpathxcbd%\rqt.dat
echo.
echo The computer has been programmed to restart on %dt% at %tm% %frec%
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

if not exist %accpathxcbd%\sqt.dat (
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
if not exist %accpathxcbd%\rqt.dat (
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
set opt=none
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
	echo : ------------------------------------------------------------------
	set slot0=False
	set /a slots="%slots%+1"
)

if exist "%accpathxcbd%\PCSHUTDOWN1" (
	type "%accpathxcbd%\PCSHUTDOWN1"
	set slot1=True
) else (
	echo : ------------------------------------------------------------------
	set slot1=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCSHUTDOWN2" (
	type "%accpathxcbd%\PCSHUTDOWN2"
	set slot2=True
) else (
	echo : ------------------------------------------------------------------
	set slot2=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCSHUTDOWN3" (
	type "%accpathxcbd%\PCSHUTDOWN3"
	set slot3=True
) else (
	echo : ------------------------------------------------------------------
	set slot3=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCSHUTDOWN4" (
	type "%accpathxcbd%\PCSHUTDOWN4"
	set slot4=True
) else (
	echo : ------------------------------------------------------------------
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
	echo : ------------------------------------------------------------------
	set slot5=False
	set /a slots="%slots%+1"
)

if exist "%accpathxcbd%\PCRESTART1" (
	type "%accpathxcbd%\PCRESTART1"
	set slot6=True
) else (
	echo : ------------------------------------------------------------------
	set slot6=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCRESTART2" (
	type "%accpathxcbd%\PCRESTART2"
	set slot7=True
) else (
	echo : ------------------------------------------------------------------
	set slot7=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCRESTART3" (
	type "%accpathxcbd%\PCRESTART3"
	set slot8=True
) else (
	echo : ------------------------------------------------------------------
	set slot8=False
	set /a slots="%slots%+1"
)
if exist "%accpathxcbd%\PCRESTART4" (
	type "%accpathxcbd%\PCRESTART4"
	set slot9=True
) else (
	echo : ------------------------------------------------------------------
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

) else if "%opt%" == "CANCEL" (
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
	echo Can't delete the schedules from database
	echo Seems some process are using it
	echo Close all other programs and try again
	echo.
	echo        [PRESS ENTER TO GO TO MENU]
	pause>nul
	color %themec%
	cls&goto main
)

if "%stak%" == "PCSHUTDOWN" goto ver1
if "%stak%" == "PCRESTART" goto ver2

:ver1
if %shutq% == "0" goto deletefinish
goto reduceshutq

:ver2
if %restq% == "0" goto deletefinish
goto reducerestq

:reduceshutq
set /a t=%shutq%-1
set shutq="%t%"
echo %shutq%>"%accpathxcbd%\sqt.dat"
goto deletefinish

:reducerestq
set /a t=%restq%-1
set restq="%t%"
echo %restq%>"%accpathxcbd%\rqt.dat"
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
echo           WARNING
echo.
echo Clean schedules means that ALL the schedules that you had programmed will be DELETED permanently.
echo.
set /p opt="Are you sure you want to processed(Y/N): "

if "%opt%" == "Y" goto cleanf
if "%opt%" == "y" goto cleanf
if "%opt%" == "N" cls&goto options
if "%opt%" == "n" cls&goto options

color 0c
echo.
echo Invalid option, just enter "Y" [YES] or "N" [NO]
echo To confirm or not the exclusion
echo.
echo        [PRESS ENTER TO TYPE AGAIN]
pause>nul
color %themec%
cls&goto clean

:cleanf
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
echo THE PROGRAM NEED TO BE RESTARTED
echo.
echo        [PRESS ENTER TO QUIT]
pause>nul
cls&goto finish

:help
echo  Hi,
echo  This is a guide that will help you to schedule the tasks you want without problems.
echo.
echo    SUMMARY
echo.
echo  1. When starting the program
echo  2. Main Menu
echo  3. Shutdown pc now
echo  4. Schedule the pc to shutdown
echo  5. Schedule the pc to restart
echo  6. Delete schedule
echo  7. Options
echo    7.1 Color themes
echo    7.2 Clean all the schedules
echo  8. Help
echo  9. Info
echo      0. Go back
echo.
echo.
set /p lk="Enter the number of topic that you want to know: "
if "%lk%" == "1" (
	goto help1
) else if "%lk%" == "2" (
	goto help2
) else if "%lk%" == "3" (
	goto help3
) else if "%lk%" == "4" (
	goto help4
) else if "%lk%" == "5" (
	goto help5
) else if "%lk%" == "6" (
	goto help6
) else if "%lk%" == "7" (
	goto help7
) else if "%lk%" == "7.1" (
	goto help7
) else if "%lk%" == "7.2" (
	goto help7
) else if "%lk%" == "8" (
	goto help8
) else if "%lk%" == "9" (
	goto help8
) else if "%lk%" == "0" (
	cls&goto main
) else (
	color 0c
	echo Error, the command "%lk%" wasn't recognized
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto help
)

:help1
cls
echo   1.When Starting the program
echo.
echo  When starting the program, you may have noticed that it takes a while to load and
echo  shows a text written "loading ...". During this "loading ..." what happens is that 
echo  it generates and loads data contained in the hidden files in the "data" folder.
echo  Therefore, if you have scheduled any shutdowns or re-initializations, never delete
echo  this folder, because the data about the schedules are stored in them, as well as 
echo  the default theme you chose. If you deleted it by accident, or out of curiosity,
echo  it can bring you a little headache. But don't worry, it is possible to solve it in 
echo  a simple way, by going to the main menu and then Go to Options, after that you 
echo  choose "Clear schedules" and confirm.
echo.
echo.
echo        [PRESS ENTER TO PROCEED]
pause>nul

:help2
cls
echo   2.Main Menu
echo.
echo  After loading, the program will present the menu that you probably saw before selecting 
echo  this option. It will contain some useful options that can help you and that will be 
echo  highlighted throughout this menu.
echo.
echo  In summary, the menu can be used in a certain way:
echo  1. If you want to shut down your computer immediately without making any kind of 
echo  scheduling, just type the option "1" (Shutdown computer now). But if you want to schedule 
echo  the computer to shut down at a different time, type option "2" (Schedule pc to shut down), 
echo  or if you want to restart the computer instead of shutting it down use option "3" 
echo  (Schedule the pc to reboot). Now, the last three options are special options: option "4" 
echo  is for deleting appointments you made previously. Option "5", on the other hand, deals with 
echo  general program options, such as changing the color theme and clearing all appointments.
echo  And the last option leads to that menu.
echo.
echo.
echo        [PRESS ENTER TO PROCEED]
pause>nul

:help3
cls
echo   3. Shutdown the pc now
echo.
echo  This option has no secret, once selected it will automatically close the program and turn off 
echo  the computer.
echo.
echo.
echo        [PRESS ENTER TO PROCEED]
pause>nul

:help4
cls
echo   4. Schedule PC to shutdown
echo.
echo  Once selected, you will be redirected to a menu where you will be asked for some information 
echo  needed to make the appointment. The program requires the time at which the shutdown task should 
echo  be performed. The hour must be informed in the following format HH: MM where "H" represents the 
echo  hours and "M" the minutes. Similarly, it will ask you to enter the date that the schedule will 
echo  start to run. The date must be informed in the following format DD / MM / YYYY where "D" are 
echo  the days "M" the months and "Y" the year, note that the number of letters in each of these gaps 
echo  represents the number of digits that should be informed, if, for example, you want the date to 
echo  be 6th, October of 2025 you must inform in that way 06/10/2025. After that choose the frequency 
echo  that you want him to perform this task, varying from one time to monthly.

echo  After choosing the correct time, the wizard will show you the saved schedules. If you don't have 
echo  any scheduling, just choose any of the slots to save. If you want to save a NEW schedule it is 
echo  recommended that you choose an empty slot. If you want to change any schedule, just enter the 
echo  number of the slot in which it is saved and confirm right after, so the old schedule will be 
echo  replaced by the new one you programmed. After scheduling, there is no longer any need to keep the 
echo  program open, you can close it and continue doing your tasks normally. But if you want to consult 
echo  an appointment you can do it through the menu to delete appointments.
echo.
echo.
echo        [PRESS ENTER TO PROCEED]
pause>nul

:help5
cls
echo   When Starting the program
echo.
echo   5. Schedule PC to restart
echo.
echo  Once selected, you will be redirected to a menu where you will be asked for some information 
echo  needed to make the appointment. The program requires the time at which the reboot task should 
echo  be performed. The hour must be informed in the following format HH: MM where "H" represents the 
echo  hours and "M" the minutes. Similarly, it will ask you to enter the date that the schedule will 
echo  start to run. The date must be informed in the following format DD / MM / YYYY where "D" are 
echo  the days "M" the months and "Y" the year, note that the number of letters in each of these gaps 
echo  represents the number of digits that should be informed, if, for example, you want the date to 
echo  be 6th, October of 2025 you must inform in that way 06/10/2025. After that choose the frequency 
echo  that you want him to perform this task, varying from one time to monthly.

echo  After choosing the correct time, the wizard will show you the saved schedules. If you don't have 
echo  any scheduling, just choose any of the slots to save. If you want to save a NEW schedule it is 
echo  recommended that you choose an empty slot. If you want to change any schedule, just enter the 
echo  number of the slot in which it is saved and confirm right after, so the old schedule will be 
echo  replaced by the new one you programmed. After scheduling, there is no longer any need to keep the 
echo  program open, you can close it and continue doing your tasks normally. But if you want to consult 
echo  an appointment you can do it through the menu to delete appointments.
echo.
echo.
echo        [PRESS ENTER TO PROCEED]
pause>nul

:help6
cls
echo   6. Delete Schedule
echo.
echo  This option will redirect you to a menu, where all the appointments you made will be displayed. If you 
echo  have not already done so it will show a warning below indicating that there are no schedules to display. 
echo  If you have an appointment it will be listed in order. If you want to delete any of your appointments, you 
echo  will have to enter the number of the appointment you wish to delete, confirm the option and your appointment 
echo  will be deleted automatically. Detail: The list of available appointments to be deleted, is not updated 
echo  instantly, it is necessary that you return to the main menu and then return to the delete schedule menu.
echo.
echo  This option is also used to consult the appointments you made previously, just cancel the operation by typing
echo  'x' or 'cancel' (without the quotes) after making your query.
echo.
echo.
echo        [PRESS ENTER TO PROCEED]
pause>nul

:help7
cls
echo   7. Options
echo.
echo  This is the general options menu that you can access. In this version there are only two options that may 
echo  interest you:
echo  + 7.1 color theme
echo  After selecting this option, there will be a formidable menu listing all the color themes available for you
echo  to use in the program. After selecting the theme that you like the most, just exit the menu (go back) and
echo  then it will save that color theme automatically, so that when you start the program again it will be
echo  already configured with the theme of your choice.
echo.
echo  + 7.2 Clear schedules
echo  This option should only be used if you really want to delete all the appointments you have made (including 
echo  the shutdown and reset schedules) at once. Or else it should be useful to you when you have problems deleting 
echo  a particular schedule, or even when a particular schedule is causing problems due to a failure of the program 
echo  or the System itself.
echo.
echo  Just select this option and confirm your choice and it will automatically delete ALL SCHEDULES made.
echo.
echo.
echo        [PRESS ENTER TO PROCEED]
pause>nul

:help8
cls
echo   8. Help
echo.
echo  It is this menu. If this menu cannot resolve any doubts you may have, consider sending an email to the creator 
echo  or opening an "ISSUE" tab on the main page of that repository on github. If you are a developer and want to
echo  contribute to the project, or want to make a modification to your own projects consider sending a "PULL REQUEST"
echo  or sending a "hi" to me via email :).
echo.
echo  My contacts are found on my GITHUB profile.
echo.
echo.
echo        [PRESS ENTER TO GO TO MENU]
pause>nul
cls&goto main

:about
echo  Sleeping Aid - Automatic Shutdown Computer Program v0.2.0 ~ Beta
echo  Copyright (C) 2020 Willian Azevedo
echo.
echo  Contributor(s): Willian Azevedo
echo.
echo  This is a free software you can redistribute it and/or modify
echo  it under the terms of MIT License.
echo.
echo        [PRESS ENTER TO GO TO MENU]
pause>nul
cls&goto main

:finish
echo %themec%>data\theme.dat
exit
