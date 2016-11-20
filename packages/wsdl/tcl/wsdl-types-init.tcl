# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>

::tws::sourceFile [file normalize [file join [file dirname [info script]] "wsdl-doc-init.tcl"]]

foreach typeNamespace {tcl} {
    ::tws::sourceFile [file normalize [file join [file dirname [info script]] "../ns/ns-${typeNamespace}.tcl"]]
}

