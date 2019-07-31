TWiST -- A Configuration Language for
tWSDL -- Tcl API for WSDL Server/Client

Installation

1. Install Tcl 8.x or use pre-installed, but you need devel files.

Here's what I used recently:

In tcl8.7a1/unix (my-configure)

#!/bin/bash

./configure --prefix=/web/servers/ns \
    --enable-threads \
    --enable-shared \
    --enable-symbols \
    --enable-64bit \
    --enable-langinfo \
    --enable-man-symlinks \
    --with-encoding=utf-8


Make changes to --prefix as required (Tcl will install in 
/web/servers/ns based upon the above --prefix, tclsh8.7 will
go into /web/servers/ns/bin


2. Install Naviserver 4.99.17 (referencing Tcl from step 0)

In naviserver/my-configure

#!/bin/bash

./configure --prefix=/web/servers/ns \
    --enable-threads \
    --with-tcl=/web/servers/ns/lib
    --enable-shared \
    --enable-symbols \
    --enable-64bit \
    --enable-langinfo \
    --enable-man-symlinks \
    --with-encoding=utf-8

3. Configure the location of your virtual server's tcl 
directory and enable tcl pages:

set server     ns
set serverroot /web/servers/$server

#
# Tcl Configuration
#
ns_section ns/server/${server}/tcl
    ns_param   library            ${serverroot}/modules/tcl
    ns_param   autoclose          on
    ns_param   debug              $debug
    ns_param   enabletclpages     true

4. Install tDOM 0.9.1 (into Tcl lib directory from step 2)


Edit the unix/CONFIG file in the tDOM directory, the result is
configure running like this:

#!/bin/bash

../configure --prefix=/web/servers/ns \
    --with-tcl=/web/servers/ns/lib \
    --enable-threads \
    --enable-shared \
    --enable-64bit \
    --enable-symbols \
    --disable-tdomalloc


Make changes to --with-tcl and  as needed.

Note that you might want to disable tdom unknown, since it makes it harder to
track down errors during development.


3. Checkout tWSDL/TWiST into the private Tcl directory of the virtual server,
or the main server's tcl library directory (from ns/server/$servername/module/tcl) 


Use these commands:

$ cd /web/servers/ns/modules/tcl
$ git clone https://github.com/russell-todd-sorensen/twist.git

4. 

Configure Naviserver to load tWSDL by adding a tcl module:


ns_section ns/server/${server}/modules
 
ns_param twsdl tcl


5. Testing: 

Large parts of tWSDL function without Naviserver. 
Additional parts work with libnsd.so loaded. Here is a 
simple method of testing that all the software is 
installed, ignoring AOLserver configuration issues:


$ cd (to twist directory containing init.tcl)

$ ls
 
add-copyright  
copyright-notice.txt  
init.tcl  
packages  
README



$ /web/servers/ns/bin/tclsh8.7 

% load /web/servers/ns/lib/libnsd.so 

% source init.tcl


Any errors should be related to missing server commands such as
ns_register_proc. You don't even need to load libnsd.so, but you then will need to load tDOM

by hand. 

Symlink package www directories to where you want them to show up under 
pageroot, for instance:

$ cd /web/servers/ns/pages
$ ln -s /web/servers/ns/modules/tcl/twist/packages/wsapi/www ws


Remove or add packages by editing the file packages/tws/tcl/tws-local-conf.tcl
(edit the list ::tws::packages, note that order may be important).


6. Enjoy!