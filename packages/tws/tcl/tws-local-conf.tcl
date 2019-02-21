# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>


# Potentially set other variable here


# load local packages
set ::tws::packages {
    tdom
    wsdb
    wsdl
    xml
    request
    inspect
    doc
    wsapi
    stockQuoter
}

::tws::util::package::loadPackages $::tws::packages

# one more thing:
::tws::log Notice "tws-local-conf.tcl Finished loading local packages"
