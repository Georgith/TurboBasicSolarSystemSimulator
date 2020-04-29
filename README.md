# TurboBasicSolarSystemSimulator

This is a later version of an old DOS Borland TurboBasic Gravity Solar System simulator I first wrote in about 1988 or so for historical reference Just for those who never saw the Old Borland TurboBasic which was really the first widepsread compiled basic available for the PC in 1987-88. I wrote this then. 

it used the classic method of computing the directional x y and z gravity force and x y z velocity of each planet on all the others and looping through until all planets were computed and then plotting the new location on the screen while beginning from the previous positions.

It does some interesting things like:
let you vary the gravity force live via a joystick which is fun to make systems contract and expand in real time

You could enter differnet timeescales for finer computations. you could even run it backward.

lets you specify a range of planet size and numbers of sun as well as dust and probes that the random generator will then use for the range of possibilities for each planet class. 

To decrease cpu use (remember this ran on 8088 and 80886 processors!) this had one class of object called "dust" and "probes" which were affected by all other larger bodies but their own gravity effect was not used to compute the others thus eliminating the exponential calculation problem when you had a lot of dust and probes. I was always going to make the probes controllable somehow or launch them on parabolic arcs but I just never did it.

also I dont think I ever finished making the inital positions and velocities start in stable orbits.
so when it runs it looks a lot like nuclear particles interacting and then flying off the screen with only a few remaining in orbits. I think it would keep track and add new bodies in when one went off screen but I cant remember.

most choices were only made by changing the variables in the program before it ran but some could be altered while running.

Also there was a function to determine the maximum resolution of the dos screen from your graphics card and choose it and then set up a system of several viewing windows for x y and z views of the planets. I made this function and then pasted it and my joystick function into most programs I wrote.

it did some crude perspective shifting in one window as well and had orbit tracing trails etc. 

it could display the planets ins several different ways as spheres or dots or circles. 

It had a function to calibrate the joystick too. 

might be fun if soemone converted it to python to run on a lot of other systems.

note: the "neatend" at the top is the result of another program I wrote which would neaten up the turbobasic code I wrote inserting proper indents etc and even followed nested lopps etc. I'll upload that later because it could the beginning basis for an interpreter or compiler. When I ran the program called "neatenup.bas on a program file it output that file to another file called "neatened.bas" and that had the date and time it was neatend at the top. Hence this.

to actually run this you would need the turbobasic runtime which was called tb.exe I beleive and you would do a command line instruction like  tb.exe planets.bas or whatever the program name was. tb.exe also had a IDE believe it or not that was pretty could with error tracing and other things. all in DOS alphanumeric windows. If you could find the runtime this would probably run in a dosbox.

apparently there is a german version of the runtime available at internet archive https://archive.org/details/BorlandTurboBasic1.0German

also there is a book about turbobasic on archive . dot org too althogh it isnt the original ownershandback and reference that came with the program. It does however explain many fo the sophisticated features of turbobasic at the time like recursiona nd case and other things https://archive.org/details/UsingTurboBasic/mode/2up

Turbobasic was extraordinary at the time becuas eit was cheap and unlike microsoft basic or qbasic etc it actually complied and gave you a standalone program you could give to your friend shwo could run it on their own dos ibm computer without and other libraries or programs needed. At that time that was pretty execptional for a low cost consumer development environemnt and program. I am pretty sure the compiler even let you compile for fastest execution or smallest size and let you choose whether or not to make it require an 8087 chip which was a "math coprocessor" which considerably sped up most math calculations! Keep in mind this was all before sound chips or graphics chips existed or were really even a dream in someones head for a consumer PC...except for Amigas.
