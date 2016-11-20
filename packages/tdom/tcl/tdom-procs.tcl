# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>

if {$::tws::AOLserver < 4.5} {
    package require tdom
} else {
    #ns_ictl package require tdom
    package require tdom
}


