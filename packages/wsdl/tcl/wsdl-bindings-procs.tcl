# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>

namespace eval ::wsdl::bindings { }


# Load Bindings:
::tws::sourceFile [file normalize [file join [file dirname [info script]] "wsdl-bindings-soap-procs.tcl"]]
