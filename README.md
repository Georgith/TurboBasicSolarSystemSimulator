# TurboBasicSolarSystemSimulator
old DOS Borland TurboBasic Gravity Solar System simulator for historical reference Just for those who never saw the Old Borland TurboBasic which was really the first widepsread compiled basic available for the PC in 1987-88. I wrote this then. 

it used the classic method of computing the directional x y and z direction force and velocity of each planet on all the others and looping through until all planets were computed and then plotting the new location on the screen while beginning for the previous positions.

It does some interesting things like:
let you vary the gravity force live via a joystick the standard gravity interaction

You could enter differnet timeescales for finer computations. you could even run it backward.

lets you specify a range of planet size and number of sun as well as dust and probes that the randon generator will then use for the range of possibilities for each planet class. 

to decrease cpu use (remember this ran on 8088 and 80886 processors!) this had one class of object called "dust" and "probes" which were affected by all other larger bodies but their own gravity effect was not used to compute the others thus eliminating the exponential calculation problem when you had a lot of dust and probes. I was always going to make the probes controllable somehow or launch them on parabolic arcs but I just never did it.

also I dont think I ever finished making the inital positions and velocities start in stable orbits.
so when it runs it looks a lot like nuclear particles interacting and then flying off the screen with only a few remaining in orbits. I think it would keep track and add new odies in when one went off screen but I cant remember.

most choices were only made by changing the variable sint he program before it ran but some could be altered while running.

Also there was a function to determien the maximum resolution of the dos screen and choose it and then set up a system of several viewing windows for x y and z views of the planets. I made this function and then pasted it and my joystick function into most programs I wrote.

it did some crude perspective shifting in one window as well and had orbit tracing trails etc. 

it could display the planets ins everal different ways as spheres or dots or circles. 

It had a function to calibrate the joystick too. 

might be fun if soemone covertedit to python to run on a lot of other systems.

note: the "neatend" at the top is the result of another program I wrote which would neaten up the turbobasic code I wrote inserting proper indents etc and even followed nested lopps etc. I'll upload that later because it could the beginning basis for an interpreter or compiler. When I ran the program called "neatenup.bas on a program file it output that file to another file called "neatened.bas" and that had the date and time it was neatend at the top. Hence this.

to actually run this you would need the turbobasic runtime whihc ws called tb.exe I beleive and you would do a command line instruction like 
tb.exe planets.bas or whatever the program name was. tb.exe also had a IDE beeliv eit or not that was pretty could with error tracing and other things. all in DOS alphanumeric windows. If you could find the runtime this would probably run in a dosbox.

apparently there is a german version available at internet archive https://archive.org/details/BorlandTurboBasic1.0German
