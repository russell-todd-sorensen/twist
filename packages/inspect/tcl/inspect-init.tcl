# (c) Russell Sorensen
# All rights reserved
# Licensed under the New BSD license:
# (http://www.opensource.org/licenses/bsd-license.php)
# Contact: Russell Sorensen <russ at semitasker.com>


# placeholder

set namespaces [::inspect::showNamespace :: 5]


foreach {depth ns} $namespaces {
    append output "\n[string repeat " " [expr 5 - $depth]]$ns"
}

log Dev $output
