# TempleOS
[TempleOS](https://templeos.org/) is a free & open source, 64-bit, multitasking operating system programmed entirely by one man, Terry A. Davis, who was at the same time a brilliant programmer and a deeply troubled man afflicted by schizophrenia.  He believed he was called by God to build the Third Temple, which was this operating system.  He died homeless and alone on August 11, 2018 when he was struck by a train.  

*Disclaimer: Davis held a number of bizarre views; the reader should not presume I share them just because I coded in TempleOS, any more than I share Linus Torvalds' politics, religion or morals because I use Linux.*

Davis programmed TempleOS in his own C-like language which he called "HolyC", which he intended to be somewhere between C and C++ in style, together with Davis' own features.  First he wrote his own compiler for HolyC and assembly language.  Then the whole operating system was written from scratch in HolyC, including interrupt handlers, drivers, etc.  He stocked it with a suite of utilities, ranging from functions typical for a shell to a 4th-order Runge-Kutta ordinary differential equation solver.  He wrote some demos and provided extensive documentation to help users.  It is a marvel for one man to have written an operating system of this scope.

Although its interface is not pretty, TempleOS is actually a fairly easy environment to learn to code in, if one already knows C.  The learning curve is not too steep.  Davis documented much of the language, and Autocomplete quickly takes you to relevant source code for function definitions. He wished it to be an operating system that people could use simply to enjoy coding, similar to his own experiences with a Commodore 64.  I'd say he was fairly successful.  And the OS is fast!

## Mandelbrot Viewer
I wrote a simple Mandelbrot set viewer just to see if I could do it.  It only took me a day to learn my way around TempleOS and another to successfully code my first program.   The experience reminded me of learning to code my first Mandelbrot program on an early [Tandy 1000](https://en.wikipedia.org/wiki/Tandy_1000) computer.

![16 color MB set](/IMG/TOS-M3.PNG)

To use it, simply mouse over the point you wish, and **press "i"** to Zoom In or **press "o"** to Zoom Out around this point.
Max iterations start at 250.  To increase them, **press "m"** for More Iterations.  The max doubles with each press.
**Press "p"** to toggle printing of the coordinates of the center point of the image, magnification scale, and max iterations.

### Iteration Mapping
You can select from 4 different types of iteration to color mapping.  Since TempleOS by design only accommodates a 16-color palette, having some iteration mapping options helps visualization.  **Press keys 1-4** for the different iteration maps, which are:
- **Linear**: simply returns `1+(iterations%15)`.  % is mod.
- **Linear/10**: returns `1+(iterations/10)%15`.  Stretches out each color over 10 iterations.
- **Sqrt**: returns `1+Sqrt(iterations)%15`.  Good for areas where iterations vary greatly.
- **Log**: returns `1+Log10(iterations)%15`.  The most aggressive option.
You may need to wait a few seconds for the updated image since it must be redrawn.
It should be easy to program your own mappings with the set-up provided.

Example:

Standard linear mapping:<br>
![Linear Map](/IMG/TOS-M5.PNG)

Same image, Linear/10 mapping:<br>
![Linear/10 Map](/IMG/TOS-M6.PNG)


### Palette changing
You can also change palettes by **pressing keys 6-9**.  Palette changes are instant, as in the good old days of VGA programming.
It should be easy to program your own palettes with the set-up provided.  The two hardest parts -- figuring out how color values are stored, and updating the palette -- have already been done.  Currently the palettes are as follows:
- TempleOS standard palette
- TempleOS standard grayscale palette
- Red-blue gradient palette
- Fiery palette

Same image as above, grayscale palette:<br>
![Grayscale palette](/IMG/TOS-M7.PNG)

## How to run the program
### Getting it on to TempleOS
Since TempleOS has no internet functionality, you either must do as they did in the 1980s and type the code in by hand, or figure out some other way to get it into the OS.  TempleOS runs well on Windows in VirtualBox.  If you choose the **.VHD** file format (or copy to it), you can mount it as a partition in Windows via Disk Manager.  Then you can copy the file into your home directory on TempleOS.

### Running it on TempleOS
You can either:

#### Run it from the editor
Navigate to the Mandelbrot.HC file, press space to load it into the editor, and press F5 to run it.
Selecting it:
![TempleOS Command Line](/IMG/TOS-M1.PNG)
<br>
The view from the editor looks like this -- now press F5 to run:
![Coding](/IMG/TOS-M2.PNG)
<br>

#### Run it from the command line:
From the command line, `#include "Mandelbrot.HC"` and press enter.  You just loaded the program into memory!  Type `Mandelbrot;` to run it.

### To quit the program
Just **Press ESC** as one does elsewhere in the OS.  Then **Press SHIFT-ESC** to quit the screen you're on and go back to your previous screen.


