
set ::doc::CutDirectory "/tws/"
set ::doc::DocRoot [file dirname "$::tws::rootDirectory"]


ns_register_filter preauth GET ${::doc::CutDirectory}*  ::doc::serveDoc
ns_register_filter preauth HEAD ${::doc::CutDirectory}* ::doc::serveDoc

