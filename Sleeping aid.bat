:: Author: Willian Azevedo 
:: Created on: 11th, October, 2020 at 01:15 P.M. (GMT-3) 
:: Last Modification on: 17th, October, 2020 at 11:42 P.M. (GMT-3) 
:: Sleeping Aid - Automatic shutdown program version 0.1.20 Alpha 
:: 
:: This is a simple batch program for automatically shutdown pc

::TODO
:: Implement an option that verify if already has a task schedule [-] (in progress) -> FIX THE BUGS, RESTRUCT ALL THE LOGIC
:: Change the rix and the six permitions
:: Create a Help Menu
:: Fix the menus of the pc shutdown [-] (in progress)
SETLOCAL DISABLEDELAYEDEXPANSION
@echo off

:load
echo Loading...
if not exist data (
	md data
	echo 0a >data\theme.dat
	md "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}"
	echo 0 >"data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\six.dat"
	echo 0 >"data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\rix.dat"
	attrib +h +s "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\six.dat"
	attrib +h +s "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\rix.dat"
	attrib +h +s "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}"
)
if not exist "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}" (
	md "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}"
	echo 0 > "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\six.dat"
	echo 0 > "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\rix.dat"
	attrib +h +s "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\six.dat"
	attrib +h +s "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\rix.dat"
	attrib +h +s "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}"
)
if not exist "data\theme.dat" echo 0a >data\theme.dat
set /p shutx=<data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\six.dat
set /p restx=<data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\rix.dat
set /p themec=<data\theme.dat

:start
color %themec%
title Sleeping aid - Automatic shutdown program (v0.1.20 alpha)
cls

:main
echo Sleeping Aid - Automatic Shutdown Program for Windows
echo version 0.1.20 Alpha
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
echo     0) exit
echo.
set /p res="Type the number of the option that you want: "

if "%res%" == "1" cls&goto turnoff
if "%res%" == "2" cls&goto schedule1
if "%res%" == "3" cls&goto schedule2
if "%res%" == "4" cls&goto deletesch
if "%res%" == "5" cls&goto options
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

:: schtasks /create /sc daily /tn PCSHUTDOWN /tr cmd shutdown /s /f /c "The windows will finish" /st 22:30 /sd 03/01/2020
:: schtasks /create /sc <scheduletype> /tn <taskname> /tr <taskrun> [/s <computer> [/u [<domain>\]<user> [/p <password>]]] [/ru {[<domain>\]<user> | system}] [/rp <password>] [/mo <modifier>] [/d <day>[,<day>...] | *] [/m <month>[,<month>...]] [/i <idletime>] [/st <starttime>] [/ri <interval>] [{/et <endtime> | /du <duration>} [/k]] [/sd <startdate>] [/ed <enddate>] [/it] [/z] [/f]
:: see this: https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/schtasks-create

:schedule1
echo Schedule the pc to shutdown
echo.
set /p tm="Enter the time (24h base time HH:MM) that you want the pc to turn off: "
if errorlevel 1 (
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
if errorlevel 1 (
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
	echo        [PRESS ENTER TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule1
)

echo.
echo Verifing...
if exist "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCSHUTDOWN%shutx%" (
	echo There is already an appointment, do you want to overwrite it
	echo.
	echo [1] Yes
	echo [2] No
	echo     [0] Cancel
	echo.
	set /p cho="Type here: "
	echo "%cho%"
	if "%cho%" == "1" (
		schtasks /delete /f /tn "PCSHUTDOWN%shutx%" >nul
		if %ERRORLEVEL% NEQ 0 (
			color 0c
			echo Error, something wrong
			echo.
			echo        [PRESS ENTER TO TYPE AGAIN]
			pause>nul
			color %themec%
			cls&goto schedule1
		)
		schtasks /create /sc %frec% /tn "PCSHUTDOWN%shutx%" /tr "shutdown /s" /st %tm% /sd %dt%
		if %ERRORLEVEL% NEQ 0 (
			color 0c
			echo Pay attention and now type a valid option
			echo.
			echo        [PRESS ENTER TO TYPE AGAIN]
			pause>nul
			color %themec%
			cls&goto schedule1
		)
		echo DATE:%dt% TIME:%tm% FREQUENCY:%frec% >"data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCSHUTDOWN%shutx%"
		echo.
		echo SUCCESS: The computer has been programmed to shutdown on %dt% at %tm% %frec% successfully
		echo.
		echo         [PRESS ENTER TO GO TO MENU]
		echo.
		pause>nul
		cls&goto main
	) else if "%cho%" == "2" (
		echo.
		echo An other schedule will be created
		echo.
		echo        [PRESS ENTER TO CONTINUE]
		pause>nul
		set /a temp=%shutx% + 1
		if %temp% GTR 4 (
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
		set shutx=%temp%
		echo %shutx% >"data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\six.dat"
	) else if "%cho%" == "0" (
		cls&goto main
	)
)
echo Applying settings...
schtasks /create /sc %frec% /tn "PCSHUTDOWN%shutx%" /tr "shutdown /s" /st %tm% /sd %dt%
if %ERRORLEVEL% NEQ 0 (
	color 0c
	echo Pay attention and now type a valid option
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule1
)
echo DATE:%dt% TIME:%tm% FREQUENCY:%frec% >"data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCSHUTDOWN%shutx%"
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
if errorlevel 1 (
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
if errorlevel 1 (
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
if exist "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCRESTART%restx%" (
	echo There is already an appointment, do you want to overwrite it?
	echo.
	echo [1] Yes
	echo [2] No
	echo     [0] Cancel
	echo.
	set /p res="Type here: "
	
	if "%res%" == "1" (
		schtasks /delete /f /tn "PCRESTART%restx%" >nul
		schtasks /create /sc %frec% /tn "PCRESTART%restx%" /tr "shutdown /r" /st %tm% /sd %dt%
		if %ERRORLEVEL% NEQ 0 (
			color 0c
			echo Pay attention and now type a valid option
			echo.
			echo        [PRESS ENTER TO TYPE AGAIN]
			pause>nul
			color %themec%
			cls&goto schedule1
		)
		echo DATE:%dt% TIME:%tm% FREQUENCY:%frec% >"data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCRESTART%restx%"
		echo.
		echo SUCCESS: The computer has been programmed to restart on %dt% at %tm% %frec% successfully
		echo.
		echo         [PRESS ENTER TO GO TO MENU]
		echo.
		pause>nul
		cls&goto main
	)
	if "%res%" == "2" (
		echo.
		echo An other schedule will be created
		echo.
		echo        [PRESS ENTER TO CONTINUE]
		pause>nul
		set /a temp=%restx% + 1
		if %temp% GTR 4 (
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
		set restx=%temp%
		echo %restx% >"data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\rix.dat"
	)
	if "%res%" == "0" cls&goto main
)
echo Applying settings...
schtasks /create /sc %frec% /tn "PCRESTART%restx%" /tr "shutdown /r" /st %tm% /sd %dt% >nul
if %ERRORLEVEL% NEQ 0 (
	color 0c
	echo Pay attention and now type a valid option
	echo.
	echo        [PRESS ENTER TO TYPE AGAIN]
	pause>nul
	color %themec%
	cls&goto schedule2
)
echo DATE:%dt% TIME:%tm% FREQUENCY:%frec% >"data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCRESTART%restx%"
echo 
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

if not exist "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\six.dat" (
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
	echo         [PRESS ENTER GO TO MENU]
	echo.
	pause>nul
	color %themec%
	cls&goto main
)
if not exist "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\rix.dat" (
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
	echo         [PRESS ENTER GO TO MENU]
	echo.
	pause>nul
	color %themec%
	cls&goto main
)
set ver=2
if not exist "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCSHUTDOWN*" set /a ver=%ver%-1 >nul
if not exist "data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCSHUTDOWN*" set /a ver=%ver%-1 >nul

if %ver% == 0 goto empty

echo All shutdown tasks
type data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCSHUTDOWN*

echo All restart tasks
type data\.schedules{31EC4020-3AEA-9069-A2DD-08002B303ID89D}\PCRESTART*


echo IN CONSTRUCTION...
echo.
echo         [PRESS ENTER GO TO MENU]
echo.
pause>nul
cls&goto main

:empty
echo.
echo No schedules to show
echo.
echo         [PRESS ENTER GO TO MENU]
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
echo        [PRESS ENTER TYPE AGAIN]
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

if "%var%" == "0" cls&goto options

color 0c
echo Error, the command "%var%" wasn't recognized
echo.
echo        [PRESS ENTER TYPE AGAIN]
pause>nul
color %themec%
cls&goto colortheme

:clean
echo TODO
pause>nul
exit

:finish
echo %themec%>data\theme.dat
exit
