::myProc ::myservice::CheckEmail4 {

    {Email!myservice::email}
    {Email2!myservice::email}
    {Email3!myservice::email}
} {
    return [list "$Email" "True"]
} returns {Email!myservice::email IsEmail!boolean}