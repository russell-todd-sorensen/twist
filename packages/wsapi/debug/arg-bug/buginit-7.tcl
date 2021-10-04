global MODES
array set MODES {ERROR 1 PARGS 2 REDO 4 LLENGTH 8}

if {![info exists env(MODE)]} {
    set env(MODE) 15
}

proc ::getElementData! {
    Child
    {ArrayName ""}
} {
    set Type [lassign [split [lindex $Child 0] !] Element]

    if {$Type == ""} {
        set Type "xsd::string"
    } elseif {$Type eq [namespace tail $Type]} {
        set Type "xsd::$Type"
    } 

    # Seed facetArray with default values:
    array set facetArray {minOccurs 1 maxOccurs 1 form Value}
    array set facetArray [lindex $Child 1]

    # Store information for later use:
    if {"$ArrayName" eq ""} {
        set ArrayName $Element
    }

    upvar $ArrayName ElementArray
    array set ElementArray [list name $Element type $Type minOccurs $facetArray(minOccurs) maxOccurs $facetArray(maxOccurs) facets [array get facetArray]  form $facetArray(form)]

    if {[info exists facetArray(default)]} {
        set ElementArray(default) $facetArray(default)
    }

    return $Element
}
proc ::printit {val} {
    puts stdout "'$val'";
}

proc ::printit2 {var} {
    upvar 1 $var lvar
    puts "$var = $lvar"
}

proc ::myProc {
    procName
    procArgsList
    procBody
    {returns ""} 
    {returnList ""}
} {
    global env MODES pargs
    set pargs [list]
    set pargs2 [list]
    set procName2 ${procName}2
    set argIndex 0
    set zeroArgs 0
    set argNameLlength0 0
    set zeroLenArgs 0

    foreach argList $procArgsList {

        if {[array exists elementData]} {
            array unset elementData
        }

        set argName [::getElementData! $argList elementData];
        set argName2 [::getElementData! $argList elementData2];

        if {($env(MODE) & $MODES(LLENGTH))} {
            if {[llength $argName] == 0} {
                incr argNameLlength0
            }
        }

        if {[info exists elementData(default)]} {
            lappend pargs [list $argName $elementData(default)]
            lappend pargs2 [list $argName2 $elementData2(default)]
        } else {
            lappend pargs [list $argName]
            lappend pargs2 [list $argName2]
        }

        incr argIndex
    }

    if {[catch {
        catch {
            puts stdout "<<about to compile>> $procName2"
            ::proc $procName2 $pargs2 $procBody
            puts stdout "<<compiling>> $procName <<succeeded>>"
        }
        puts stdout "<<about to compile>> $procName"
        ::proc $procName $pargs $procBody
        puts stdout "<<compiling>> $procName <<succeeded>>"
    } err]} {
        global errorInfo
        if {($env(MODE) & $MODES(ERROR))} {
            puts stdout "proc $procName failed with error '$errorInfo', trying again"
        }
        if {($env(MODE) & $MODES(PARGS))} {
            puts stdout "argCount = [llength $pargs] pargs=$pargs"
        }
        if {($env(MODE) & $MODES(REDO))} {
            puts stdout "<<about to re-compile>> $procName"
            ::proc $procName $pargs $procBody
            puts stdout "<<compiling>> $procName <<succeeded>>"
        }
    }
}

if {[info exists ::myservice::destroyMe] && $::myservice::destroyMe eq "true"} {

    namespace delete ::myservice

} elseif {[namespace exists ::myservice]} {
    return -code return
}

namespace eval ::myservice {
    variable destroyMe true
}

lappend message "Set env(MODE) as sum of these modes:"
lappend message [format "%10.10s %3.3s" Name Val]
foreach {mode value} [lsort -integer -increasing -stride 2 -index 1 [array get MODES]] {
    lappend message [format "%10.10s %3d" $mode $value]
}
lappend message "Current Config:"
lappend message "set env(MODE) $env(MODE)"
puts [join $message "\n"]