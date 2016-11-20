# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>


namespace eval ::wsdb:: { }
    
namespace eval ::wsdb::globalTypes {}

::tws::sourceFile [file normalize [file join [file dirname [info script]] "wsdb-schema-procs.tcl"]]
