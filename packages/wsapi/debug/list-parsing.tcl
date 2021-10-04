set a { {e f g
} r n g

}
set b { 	
	rr g d}
 	
set c { r e a {y u}
c ll {5 9	}
	u 	tt
	}

set d {
:        {Symbol:stock::symbol {maxOccurs 3}}
:        {Verbose:stock::verbose {minOccurs 0 default 0}}
:    }


set e {
    {x 5}
    {y 6}
    }

proc f $e {puts [expr {$x+$y}]}

proc test-bad {{g "h"} {} } {
    puts "this is bad $a and $b"
}