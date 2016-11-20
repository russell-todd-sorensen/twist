# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>



namespace eval ::wsdl::services {

    namespace import ::tws::log::log

}

proc ::wsdl::services::new {

    serviceName
    args
} {

    namespace eval ::wsdb::services { }
    namespace eval ::wsdb::services::${serviceName} {
	variable ports
    }

    set ::wsdb::services::${serviceName}::ports $args
}
