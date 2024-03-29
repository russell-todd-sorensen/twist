# XML-Schema has many, maybe too many date/time types.
# This Web Service will allow testing of these types.

<ws>namespace init ::datetime

<ws>proc ::datetime::CheckDateTime {

    {DateTime!dateTime}
} {

    return [list $DateTime True]

} returns {DateTime!dateTime IsDateTime!boolean}


<ws>proc ::datetime::ShowDateTimeComponents {

    {DateTime}
} {
    set IsDateTime [::wsdb::types::tcl::dateTime::toArray $DateTime DT]
    ::tws::log::log Notice "ShowDateTimeComponents DT=[array get DT]"
    if {!$IsDateTime} {
        return [list $DateTime False]
    } else {
        return [list $DateTime True $DT(all) $DT(YMD) $DT(year) \
            $DT(Positivity) $DT(month) $DT(day) $DT(HMS) $DT(hour) $DT(minute) $DT(second)\
            $DT(SecondWhole) $DT(SecondFract) $DT(Timezone) $DT(TZSign)  $DT(TZValue) \
            $DT(TZ14Hour) $DT(TZ14Min) $DT(TZHour) $DT(TZMin)]
    }

} returns {
    TestString 
    IsDateTime!boolean
    {All {minOccurs 0}}
    {YMD!dateTime {minOccurs 0}}
    {Year!gYear {minOccurs 0}}
    {Positivity!minusOptional {minOccurs 0}}
    {Month!gMonth {minOccurs 0}}
    {Day!gDay {minOccurs 0}}
    {HMS {minOccurs 0}}
    {Hour {minOccurs 0}}
    {Minute {minOccurs 0}}
    {Second {minOccurs 0}}
    {SecondWhole {minOccurs 0}}
    {SecondFract {minOccurs 0}}
    {Timezone {minOccurs 0}}
    {TZSign {minOccurs 0}}
    {TZValue {minOccurs 0}}
    {TZ14Hour {minOccurs 0}}
    {TZ14Min {minOccurs 0}}
    {TZHour {minOccurs 0}}
    {TZMin {minOccurs 0}}
}

<ws>proc ::datetime::AddDurationToDateTime {

    {StartDateTime!dateTime}
    {Duration!duration}
} {

    set dateValid [::wsdb::types::tcl::dateTime::toArray $StartDateTime inDateArray]
    set durationValid [::wsdb::types::tcl::dateTime::durationToArray $Duration durationArray]
    array set tmpDurationArray [array get durationArray]

    foreach {element value} {year 0 month 0 day 0 hour 0 minute 0 second 0} {

        if {"$durationArray($element)" eq ""} {
            set tmpDurationArray($element) "$value"
        }
    }
    
    ::wsdb::types::tcl::dateTime::addDuration inDateArray tmpDurationArray outDateArray

    ::tws::log::log Notice "AddDurationToDateTime: Finished adding duration, formatting"

    set outDate [::wsdb::types::tcl::dateTime::formatDateTime outDateArray]

    return [list $StartDateTime $Duration $outDate]

} returns {StartDateTime!dateTime Duration!duration EndDateTime!dateTime}

set minusOptional {(-)?}
set minusOptionalAnchored {\A(-)?\Z}

set year {(-)?([0-9]{4}|[1-9]{1}[0-9]{4,})}
set yearAnchored {\A(-)?([0-9]{4}|[1-9]{1}[0-9]{4,})\Z}

set timezone {(Z|(([\+\-]{1}))?((?:(14)(?::)(00))|(?:([0][0-9]|[1][0-3])(?::)([0-5][0-9]))))}
set timezoneOptional ${timezone}?
set timezoneAnchored "\\A$timezoneOptional\\Z"

set gYear ${year}${timezoneOptional}
set gYearAnchored "\\A${gYear}\\Z"

set day {([0][0-9]|[12][0-9]|[3][01])}

set gDay ${day}${timezoneOptional}
set gDayAnchored "\\A${gDay}\\Z"

set month {(?:([0][1-9]|[1][0-2]))}

set gMonth ${month}${timezoneOptional}
set gMonthAnchored "\\A${gMonth}\\Z"

set gYearMonth ${year}(?:-)${month}
set gYearMonthAnchored "\\A${gYearMonth}\\Z"

set gMonthDay ${month}(?:-)${day}
set gMonthDayAnchored "\\A${gMonthDay}\\Z"

# <ws>type API examples:
<ws>type pattern datetime::word {[^[:space:]]}

<ws>type enumeration datetime::dayName {Monday Tuesday
    Wednesday Thursday Friday Saturday Sunday} datetime::word

<ws>type enumeration datetime::dayNumber {0 1 2 3 4 5 6} xsd::integer

<ws>type pattern datetime::minusOptional $minusOptionalAnchored
<ws>type pattern datetime::year $yearAnchored xsd::integer
<ws>type pattern datetime::timeZone $timezoneAnchored
<ws>type pattern datetime::gYear $gYearAnchored
<ws>type pattern datetime::gMonth $gMonthAnchored
<ws>type pattern datetime::gDay $gDayAnchored
<ws>type pattern datetime::gYearMonth $gYearMonthAnchored
<ws>type pattern datetime::gMonthDay $gMonthDayAnchored


<ws>proc ::datetime::DayNameFromNumber {
    {DayNumber!datetime::dayNumber}
} {
    return [lindex {
    Monday Tuesday
    Wednesday Thursday Friday
    Saturday Sunday} $DayNumber]
} returns {DayName!datetime::dayName}

<ws>namespace finalize ::datetime

#<ws>namespace freeze ::datetime

<ws>return ::datetime