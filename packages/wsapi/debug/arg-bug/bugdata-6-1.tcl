::myProc ::myservice::echoInfo {
    {Email!email} 
    {Age!integer} 
    {GenderPreference!myservice::Gender {default "Male"}}
} {
    return [list "$Email" "True" Age $Age GenderPreference $GenderPreference]
} returns {Email!email IsEmail!boolean Age!integer GenderPreference!myservice::Gender}