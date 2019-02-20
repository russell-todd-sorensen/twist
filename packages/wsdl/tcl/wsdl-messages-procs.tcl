# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>


# NOTE: looks like messages, operations, porttypes will be in same namespace
namespace eval ::wsdl::messages {

    namespace import ::tws::log::log
}


proc ::wsdl::messages::new {
    messageNamespace
    messageName
    args
} {

    set script ""
    append script "
namespace eval ::wsdb::messages::${messageNamespace} \{ \}

namespace eval ::wsdb::messages::${messageNamespace}::${messageName} \{
    variable Parts \[list\]
\}"


    foreach Part $args {
        append script "
lappend ::wsdb::messages::${messageNamespace}::${messageName}::Parts \"$Part\""

    }

    return $script
}
