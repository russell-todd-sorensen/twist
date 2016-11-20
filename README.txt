tWSDL -- Tcl API for WSDL Server/Client

Installation (temporary instructions)


0. Install Tcl 8.4

I use a file to hold my configure params create a file in

the tcl8.4.9/unix directory:

#!/bin/bash

./configure --prefix=/web/m2 \

            --enable-threads \

            --enable-symbols \

            --enable-shared


Make changes to --prefix as required (Tcl will install in 
/web/m2/lib based
upon the above --prefix, tclsh8.4 will
go into /web/m2/bin.



1. Install AOLserver 4.5 (referencing Tcl from step 0)



I use a file to hold my configure params create a file in

the AOLserver source directory with this contents:


#!/bin/bash

./configure --prefix=/web/nsd45 \

        --with-tcl=/web/m2/lib \

        --enable-debug \

        --enable-symbols \

        --enable-shared



Make changes to --prefix and --with-tcl as required


You may have to edit some compile/install files to reflect the path

to the tclsh8.4 installed in step 0.



2. Install tDOM 0.8.0 (into Tcl lib directory from step 0)


Create a file as follows: 


#!/bin/bash

../configure --enable-threads \

        --enable-shared \

        --enable-dtd \

        --enable-ns \

        --disable-unknown \

        --disable-tdomalloc \

        --with-tcl=/web/m2/lib \

        --with-aolserver=/web/nsd45



Make changes to --with-tcl and --with-aolserver as needed.

Note that I have disabled tdom unknown, since it makes it harder to

track down errors during development.



3. Checkout tWSDL into the private Tcl directory of the virtual server

   
If AOLserver Home = /web/nsd45, 
Virtual servers are under /web/nsd45/servers

For virtual server wstest,

Private Tcl Directory = /web/nsd45/servers/wstest/modules/tcl


Or the Private Tcl Directory can be set using, for instance:



ns_section  ns/server/${server}/tcl
 
ns_param   library        "$home/servers/${server}/modules/tcl"

 ns_param   autoclose      "on" 

 ns_param   debug          "true" ;# false

 ns_param   SharedLibrary  "$home/modules/tcl" 

 ns_param   initfile       "$home/bin/init.tcl"

 ns_param   nsvbuckets     "8"



The ns_param library gives the full path.


Use these commands:

$ cd /web/nsd45/servers/wstest/modules/tcl
$ svn checkout http://twsdl.googlecode.com/svn/trunk/ twsdl

4. 

Configure AOLserver to load tWSDL by adding a tcl module:



ns_section ns/server/${server}/modules
 
ns_param twsdl tcl



5. Testing: 

Large parts of tWSDL function without AOLserver. 
Additional parts work
with libnsd.so loaded. Here is a simple method
of testing that all the 
software is installed, ignoring AOLserver configuration issues:


$ cd (to twsdl directory containing init.tcl)

$ ls
 
add-copyright  
copyright-notice.txt  
init.tcl  
packages  
README



$ /web/m2/bin/tclsh8.4  

% load /web/nsd45/lib/libnsd.so 

% source init.tcl



Any errors should be related to missing server commands such as

ns_register_proc.
You don't even need to load libnsd.so, but you then will need to load tDOM

by hand. 

Symlink package www directories to where you want them to show up under 
pageroot.


Remove or add packages by editing the file packages/tws/tcl/tws-local-conf.tcl
(
edit the list ::tws::packages, note that order may be important).



6. Enjoy!

