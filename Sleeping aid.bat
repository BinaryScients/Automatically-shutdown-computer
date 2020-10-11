:: Author: Willian Azevedo 
:: Created on: 11th, October, 2020 at 01:15 P.M. (GMT-3) 
:: Last Modification on: 11th, October, 2020 at 01:15 P.M. (GMT-3) 
:: Sleeping Aid - Automatic shutdown program version 0.1.0 Alpha 
:: 
:: This is a simple batch program for automaticly shutdown pc


:start
@echo off
color 3f
title Sleeping aid - Automatic shutdown program (v0.1.0 alpha)
cls

:main
echo Welcome to Sleeping Aid
echo.
echo.
echo What you want to do now?
echo.
echo.
echo 1) Shutdown the pc
echo 2) Schedule the pc to shutdown
echo 3) exit
echo.
set /p res="Type the number of the option that you want: "

if %res% == "1" goto turnoff
if %res% == "2" goto schedule
if %res% == "3" goto finish

:turnoff
echo.
echo.
echo.
echo Press enter to shutdown now
echo.
pause>nul
shutdown /s /f
cls&goto finish


:schedule
echo Schedule the pc to shutdown
echo.
set /p sc="Enter the time you want the pc to turn off: "
if errorlevel(
	echo Error, type again
	goto schedule
)
echo How many times do you want him to hang up at this time?
echo.
echo 1) Once
echo 2) Everyday
echo.
set /p opt="type here: "

if %opt% == "1" goto once
if %opt% == "2" goto settings

:once
::TODO

:settings
::TODO


:finish
exit
