global MODES
array set MODES {ERROR 1 PARGS 2 REDO 4 LLENGTH 8}

if {![info exists env(MODE)]} {
    set env(MODE) 15
}

proc ::getElementData {
    Child
    {ArrayName ""}
} {
    set ChildNameType [lindex $Child 0]
    set first [string first ":" $ChildNameType]
    if {$first > -1} {
        set Element [string range $ChildNameType 0 [expr $first -1 ]]
        #puts stdout "Element ='[string range $ChildNameType 0 [expr $first -1 ]]'"
        set Type [string range $ChildNameType [expr $first + 1] end]
        if {"$Type" eq ""} {
            set Type "xsd::string"
        } elseif {[string first ":" "$Type"] == -1} {
            set Type "xsd::$Type"
        }
    } else {
        set Element $ChildNameType
        #puts stdout "Element(from ChildNameType var)='$ChildNameType'"
        set Type "xsd::string"
    }

    # Seed facetArray with default values:
    array set facetArray {minOccurs 1 maxOccurs 1 form Value}
    array set facetArray [lindex $Child 1]

    #lappend Elements $Element

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
    set argIndex 0
    set zeroArgs 0
    set argNameLlength0 0
    set zeroLenArgs 0

    foreach argList $procArgsList {

        if {[array exists elementData]} {
            array unset elementData
        }

        set argName [::getElementData $argList elementData];

        if {($env(MODE) & $MODES(LLENGTH))} {
            if {[llength $argName] == 0} {
                incr argNameLlength0
            }
        }

        if {[info exists elementData(default)]} {
            lappend pargs [list $argName $elementData(default)]
        } else {
            lappend pargs [list $argName]
        }

        incr argIndex
    }

    if {[catch {
        ::proc $procName $pargs $procBody
    } err]} {
        global errorInfo
        if {($env(MODE) & $MODES(ERROR)) == $MODES(ERROR)} {
            puts stdout "proc $procName failed with error '$errorInfo', trying again"
        }
        if {($env(MODE) & $MODES(PARGS)) == $MODES(PARGS)} {
            puts stdout "argCount = [llength $pargs] pargs=$pargs"
        }
        if {($env(MODE) & $MODES(REDO)) == $MODES(REDO)} {
            ::proc $procName $pargs $procBody
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
    lappend message [format "%10.10s %0.3d" $mode $value]
}
lappend message "Current Config:"
lappend message "set env(MODE) $env(MODE)"
puts [join $message "\n"]