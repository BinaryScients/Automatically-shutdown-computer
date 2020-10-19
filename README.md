# Automatically Shutdown Computer - Sleeping Aid program verion 0.1.35 Alpha

This is a simple program that helps Windows users to schedule their computers to shutdown

With just a few commands you can program your computer to shut down at the time you want it every day (or only on the days you determine). This script uses Windows' own resources to schedule shutdown.

## How to install?

 - There is no need to install third party utilities
 - There is no need to execute complicated commands
 - There is no need to frameworks, or whatever
 
 Just download the zip file and extract it to the folder :D

## How to use it?



1. Open the "Sleeping aid" program. The .bat or .exe file
<p align="left">
  <img src="https://raw.githubusercontent.com/BinaryScients/Automatically-shutdown-computer/master/resources/files.PNG" width="350" title="Sleeping aid program">
</p>
2. Choose one of the options.
<p align="left">
  <img src="https://raw.githubusercontent.com/BinaryScients/Automatically-shutdown-computer/master/resources/presentation.PNG" width="900" title="Main menu">
</p>
3. Choose the time that you prefer the computer to turn off.
<p align="left">
  <img src="https://raw.githubusercontent.com/BinaryScients/Automatically-shutdown-computer/master/resources/schedule-1.PNG" width="900" title="Schedule">
</p>
4. Choose the date that you want the rule to start taking effect.
<p align="left">
  <img src="https://raw.githubusercontent.com/BinaryScients/Automatically-shutdown-computer/master/resources/schedule-2.PNG" width="900" title="Schedule>
</p>
5. Choose the frequency at which the computer will shut down. For example, weekly.
<p align="left">
  <img src="https://raw.githubusercontent.com/BinaryScients/Automatically-shutdown-computer/master/resources/schedule-3.PNG" width="900" title="Schedule">
</p>
6. Done, just close the program and the Windows will automatically shut down at the time you chose.
<p align="left">
  <img src="https://raw.githubusercontent.com/BinaryScients/Automatically-shutdown-computer/master/resources/schedule-4.PNG" width="900" title="Schedule">
</p>

Very simple, isn't it? :)

## Deleting Schedules

If you do not want more than a certain scheduled task to be executed, you can delete it by going to the "Delete schedule" menu and choosing the task you wish to delete.
<p align="left">
  <img src="https://raw.githubusercontent.com/BinaryScients/Automatically-shutdown-computer/master/resources/delete-schedule-1.PNG" width="720" title="Delete schedule">
  <img src="https://raw.githubusercontent.com/BinaryScients/Automatically-shutdown-computer/master/resources/schedule-5.PNG" width="720" title="Delete schedule">
</p>



## Color themes

You can also choose a color theme that you prefer

<p align="right">
  <img src="https://raw.githubusercontent.com/BinaryScients/Automatically-shutdown-computer/master/resources/color-theme.PNG" width="900" title="Color theme menu">
</p>


## Disclaimer

This program is still under development, and may present some instabilities, bugs and other errors. If you want to contribute to this project, you can send a pull request or report problems that you have in the "issues" tab. Don't forget to send your screenshots if possible.

If you made several appointments with the script and are having several problems with those appointments, and you aren't able to delete them. I suggest you open the prompt: "Windows key" + "R" and type "cmd" + ENTER
Then type the following command in the prompt:
```
schtasks / delete / f / tn "PCSHUTDOWN0"
```
And change the "0" of the <b> "PCSHUTDOWN0" </b> by 1, 2 to the number 4. If it fails, it is because this task has already been deleted or has not been created yet.
Repeat the same procedure with the restart tasks, if you have programmed, by typing the following command:
```
schtasks / delete / f / tn "PCRESTART0"
```
You can also choose to go to the "clean schedules" option located in the "Go to options" menu, in the Sleeping aid program. It deletes all tasks created automatically.