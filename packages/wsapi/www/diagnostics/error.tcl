set vars [info vars]

global errorInfo

set result [list $errorInfo]

foreach var $vars {
    if {"$var" eq "errorInfo"} {
        continue
    }
    if {[array exists $var]} {
        set keys [lsort [array names $var]]
        lappend result "<b>Array $var</b>"
        foreach key $keys {
            lappend result " $key = [set ${var}($key)]"
        }
    } else {
        lappend result "$var = '[set $var]'"
    }
}

ns_return 200 text/html "<!DOCTYPE html>
<html charset='utf-8'>
<head>
<title>Config for [ns_info server]</title>
</head>
<body>
<pre>
[join $result "\n"]
</pre>

</body>
</html"