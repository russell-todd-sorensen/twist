<!DOCTYPE html>
<html charset='utf-8'>
<head>
<title>Config for <% ns_info server %></title>
</head>
<body>

<% 
global errorInfo
 %>
 <pre>
 <%= $errorInfo %>
</pre>

<%
    set vars [info vars]
    set result [list]
    ns_log Notice "vars='[info vars]'"
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
%>
<pre>
<%= [join $result "\n"] %>
</pre>
</body>

</html>