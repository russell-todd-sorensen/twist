# Test out legal args to proc

set procParts {
    {
        t1
        {
            "a s p a c e"
            {n 0}
        }
        {
            return [lindex ${a s p a c e} $n]
        }
    }
    {
        t1
        {
            {"a s p a c e"}
            {n 0}
        }
        {
            return [lindex ${a s p a c e} $n]
        }
    }
}

proc assembleAndRun {procList} {
    set procName [lindex $procList 0]
    if {[llength [info proc $procName]]} {
        return -code error "Refuse to redefine proc '$procName"
    }
    if {[catch {
        proc {*}$procList
        set arguments [info args $procName]
    } err]} {
        global errorInfo
        return -code error "Oops error running $procList starting over  '$errorInfo'"
    }
    if {[catch {
        set inputs [list]
        foreach arg $arguments {
            set hasDefault [info default $procName $arg value]
            puts stdout "Enter value for '$arg' [expr {$hasDefault?"(default:'$value')":""}]:"
            if {[set len [gets stdin $arg]] > -1} {
                if {$len} {
                    lappend inputs [set $arg]
                } elseif {$hasDefault} {
                    lappend inputs $value 
                } else {
                    return -code error "Problem with arg '$arg' value '$value'"
                }
            }
        }
    } err]} {
        rename $procName ""
        global errorInfo
        return -code error "Oops error with proc '$procName', arg '$arg' $errorInfo"
    }
    if {[catch {
        set result [$procName {*}$inputs]
    } err]} {
        rename $procName ""
        global errorInfo
        return -code error "problem running '$procName' with inputs '$inputs' $errorInfo"
    }
    if {[catch {
        puts "result of $procName with args $inputs: '$result'"
    } err]} {
        rename $procName ""
        global errorInfo
        return -code error "problem $errorInfo"
    }
    rename $procName ""
}

puts "Enter proc number to execute: (ctrl-Z to exit)"

while {[gets stdin num] > -1} {

    switch -exact -- $num {
        0 {
           assembleAndRun  {t1 { "a s p a c e" {n 0}} {
                return [lindex ${a s p a c e} $n]}}
        }
        1 {
            assembleAndRun {t2 { {"a s p a c e"} {n 0}} {
                return [lindex ${a s p a c e} $n]}}
        }
        2 {
            assembleAndRun {t3 { {{a s p a c e}} {n 0}} {
                return [lindex ${a s p a c e} $n]}}
        }
        3 {
            assembleAndRun {t3 { "{a s p a c e}" {n 0}} {
                return [lindex ${a s p a c e} $n]}}
        }
        4 {
            assembleAndRun [lindex $procParts 0]
        }
        5 {
            assembleAndRun [lindex $procParts 1]
        }
    }
    puts "Try Another? (ctrl-Z to exit) num="
}