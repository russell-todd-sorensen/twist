# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>


namespace eval ::wsdl::portTypes { 

    namespace import ::tws::log::log

}


proc ::wsdl::portTypes::new {

    portTypeNamespace
    portTypeName
    operationList
} {

    namespace eval ::wsdb::portTypes::${portTypeNamespace} { }
    
    namespace eval ::wsdb::portTypes::${portTypeNamespace}::${portTypeName} {
	variable operations 
    }
    
    set ::wsdb::portTypes::${portTypeNamespace}::${portTypeName}::operations $operationList
}

