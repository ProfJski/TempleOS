# TempleOS
[TempleOS](https://templeos.org/) is a free & open source, 64-bit, multitasking operating system programmed entirely by one man, Terry A. Davis, who was at the same time a brilliant programmer and a deeply troubled man afflicted by schizophrenia.  He believed he was called by God to build the Third Temple, which was this operating system.  He died homeless and alone on August 11, 2018 when he was struck by a train.

Davis programmed TempleOS in his own C-like language which he called "HolyC", which he intended to be somewhere between C and C++ in style, together with Davis' own features.  So first he wrote his own compiler for HolyC and assembly language.  The whole operating system was written from scratch, including interrupt handlers, drivers, etc.  He also stocked it with a suite of utilities and little demos.  It is a marvel for one man to have written an operating system of this scope.

Although its interface is not pretty, TempleOS is actually a fairly easy environment to learn to code in, if one already knows C.  The learning curve is not too steep.  Davis documented much of the language, and an Autocomplete quickly takes you to relevant source code. He wished it to be an operating system that people could use simply to enjoy coding, similar to his own experiences with a Commodore 64.  I'd say he was fairly successful.  And the OS is fast!

## Mandelbrot Viewer
I wrote a simple Mandelbrot set viewer just to see if I could do it.  It only took me a day to learn my way around the OS and another to successfully code my first program.   The experience reminded me of learning to code my first such program on an early Tandy computer.

To use it, simply mouse over the point you wish, and **press "i"** to Zoom In or **press "o"** to Zoom Out around this point.
Max iterations start at 250.  To increase them, **press "m"** for More Iterations.  The max doubles with each press.
**Press "p"** to toggle printing of the coordinates of the center point of the image, magnification scale, and max iterations.

### Iteration Mapping
You can select from 4 different types of iteration to color mapping.  Since TempleOS by design only accommodates a 16-color palette, having some iteration mapping options helps visualization.  **Press keys 1-4** for the different iteration maps, which are:
- Linear: simply returns iterations mod 15.
- Linear/10: returns (iterations/10) mod 15.
- Sqrt: returns Sqrt(iterations) mod 15.
- Log: returns Log10(iterations) mod 15.
You may need to wait a few seconds for the updated image since it must be redrawn.
It should be easy to program your own mappings with the set-up provided.

### Palette changing
You can also change palettes by **pressing keys 6-9**.  Palette changes are instant, as in the good old days of VGA programming.
It should be easy to program your own palettes with the set-up provided.  The two hardest parts -- figuring out how color values are stored, and updating the palette -- have already been done.  Currently the palettes are as follows:
- TempleOS standard palette
- TempleOS standard grayscale palette
- Red-blue gradient palette
- Fiery palette

## How to run the program
### Getting it on to TempleOS
Since TempleOS has no internet functionality, you either must do as they did in the 1980s and type the code in by hand, or figure out some other way to get it into the OS.  TempleOS runs well on Windows in VirtualBox.  If you choose the **.VHD** file format (or copy to it), you can mount it as a partition in Windows via Disk Manager.  Then you can copy the file into your home directory on TempleOS.

### Running it on TempleOS
You can either:
Navigate to the Mandelbrot.HC file, press space to load it in the editor, and press F5 to run it.
or,
From the command line, `#include "Mandelbrot.HC"` and press enter.  Next type a semicolon `;` and press enter.  You just loaded the program into memory.  Type `Mandelbrot;` to run it.

### To quit the program
Just **Press ESC** as one does elsewhere in the OS.  Then **Press SHIFT-ESC** to quit the screen you're on and go back to your previous screen.





