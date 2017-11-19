For the Arduino IDE's examples and library directories a file name and folder convention is required.

When I first created all the examples I didn't do this and wanted an automatic way to create and move the required directories.  This led me to learm a bit more about [strring manipulation in bash](http://mywiki.wooledge.org/BashFAQ/100)

Finally I figured out the required commands. This was executed in each director I had a bunch of *.ino files and needed to make directories for.

Firstly I `cd` to get the files needing directorring in the the current directory (/usr/share/arduino/examples/*)

Then I went through each:

```	
for file in *.ino; do mkdir -- "${file%.txt}"; mv -- "$file" "${file%.ino}"; done
```
