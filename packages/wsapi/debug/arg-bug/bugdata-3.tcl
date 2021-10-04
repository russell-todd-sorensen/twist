::myProc ::myservice::CheckEmail4 {{Email!myservice::email} {Email2!myservice::email} {Email3!myservice::email {default "r@t.s"}}} {
    return [list "$Email" "True"]
} returns {Email!myservice::email IsEmail!boolean}