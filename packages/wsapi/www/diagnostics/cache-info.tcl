
set body "error"
set err "no error"
catch {set body [info body "ns:tclcache.c:/naviserver/servers/twt/tcl/twist/packages/wsapi/www/address/index.tcl"]} err
ns_return 200 text/plain "body=$body
err=$err"