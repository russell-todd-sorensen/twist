# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>



namespace eval ::wsdl::ports {

    namespace import ::tws::log::log

}

proc ::wsdl::ports::new {
    
    portName
    bindingName
    portAddress
} {

    namespace eval ::wsdb::ports { }
    namespace eval ::wsdb::ports::$portName {
	variable binding
	variable address
    }
    set ::wsdb::ports::${portName}::binding $bindingName
    set ::wsdb::ports::${portName}::address $portAddress

}
