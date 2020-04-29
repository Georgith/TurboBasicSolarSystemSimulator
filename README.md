# TurboBasicSolarSystemSimulator
old DOS Borland TurboBasic Gravity Solar System simulator for historical reference Just for those who never saw the Old Borland TurboBasic which was really the first widepsread compiled basic available for the PC in 1987-88. I wrote this then. 


It does some interesting things like:
let you vary the gravity force live via a joystick the standard gravity interaction

lets you specify a range of planet size and number of sun as well as dust and probes that the randon generator will then use for the range of possibilities for each planet class. 

to decrease cpu use (remember this ran on 8088 and 80886 processors!) this had one class of object called "dust" and "probes" which were affected by all other larger bodies but their own gravity effect was not used to compute the others thus eliminating the exponential calculation problem when you had a lot of dust and probes. 

Also there was a function to determien the maximum resolution of the dos screen and choose it and then set up a system of several viewing windows for x y and z views of the planets.

it did some crude perspective shifting in one window as well and had orbit tracing trails etc. c

ould display the planets ins everal different ways as spheres or dots or circles. 

It had a function to calibrate the joystick too. 

might be fun if soemone covertedit to python to run on a lot of other systems.

note: the "neatend" at the top is the result of another program I wrote which would neaten up the turbobasic code I wrote inserting proper indents etc and even followed nested lopps etc. I'll upload that later because it could the beginning basis for an interpreter or compiler. When I ran the program called "neatenup.bas on a program file it output that file to another file called "neatened.bas" and that had the date and time it was neatend at the top. Hence this.

to actually run this you would need the turbobasic runtime whihc ws called tb.exe I beleive and you would do a command line instruction like 
tb.exe planets.bas or whatever the program name was. tb.exe also had a IDE beeliv eit or not that was pretty could with error tracing and other things. all in DOS alphanumeric windows. If you could find the runtime this would probably run in a dosbox.
