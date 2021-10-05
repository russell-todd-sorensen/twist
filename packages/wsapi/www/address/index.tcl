<ws>namespace delete ::address
<ws>namespace init ::address
<ws>namespace schema address "urn:com:semitasker:twist:ws:address:v.1"

<ws>type simple address::testId xsd::unsignedByte
<ws>type stringRestrict address::companyName {maxLength 80}
<ws>type stringRestrict address::addressLineOne {maxLength 80}
<ws>type stringRestrict address::addressLineTwo {maxLength 80}
<ws>type stringRestrict address::city {maxLength 80}
<ws>type enum address::stateCode [lsort {AL CA WA TX MA MS LA NM AZ}]
<ws>type pattern address::zipPlusFour {[0-9]{5}(-[0-9]{4})?}

<ws>element sequence address::fromAddress {
    {addressId!address::testId {minOccurs 1 maxOccurs 1}}
    {fromCompany!address::companyName {minOccurs 1 maxOccurs 1}}
    {fromAddress1!address::addressLineOne {minOccurs 1 maxOccurs 1}}
    {fromAddress2!address::addressLineTwo {minOccurs 0 maxOccurs 1}}
    {fromCity!address::city {minOccurs 1 maxOccurs 1}}
    {fromState!address::stateCode {minOccurs 1 maxOccurs 1}}
    {fromZip!address::zipPlusFour {minOccurs 1 maxOccurs 1}}
}

<ws>element sequence address::toAddress {
    {addressId!address::testId {minOccurs 1 maxOccurs 1}}
    {toCompany!address::companyName {minOccurs 1 maxOccurs 1}}
    {toAddress1!address::addressLineOne {minOccurs 1 maxOccurs 1}}
    {toAddress2!address::addressLineTwo {minOccurs 0 maxOccurs 1}}
    {toCity!address::city {minOccurs 1 maxOccurs 1}}
    {toState!address::stateCode {minOccurs 1 maxOccurs 1}}
    {toZip!address::zipPlusFour {minOccurs 1 maxOccurs 1}}
}

<ws>element sequence address::fromToEnvelope {
    {envelopeId!address::testId }
    {fromAddr!elements::address::fromAddress {form List}}
    {toAddr!elements::address::toAddress {form List}}
}


<ws>proc address::sendMail {
    {From!elements::address::fromToEnvelope }
} {
    return $From
} returns {
    fromToEnvelope
}

<ws>proc address::sendMail2 {
    {envelopeId!address::testId {minOccurs 1 default 125}}
    {fromAddress!elements::address::fromAddress {form Element minOccurs 1 default {{1} {x} {y} {z} {a} {WA} {98198}}}}
    {toAddress!elements::address::toAddress {form List minOccurs 1 default {{2} {a} {b} {c} {x} {WA} {98198-5115}}}}
} {
    <ws>log Notice "$envelopeId='$envelopeId', fromAddress='$fromAddress', toAddress='$toAddress'"
    return [list $envelopeId $fromAddress $toAddress]
} returns {
    {envelopeId!address::testId }
    {fromAddrress!elements::address::fromAddress {form List}}
    {toAddrress!elements::address::toAddress {form List}}
}

<ws>proc address::EchoAddress {
    fromAddress
} {
    set vars [info vars]
    set result [list]
    ns_log Notice "vars='[info vars]'"
    foreach var $vars {
        lappend result [set $var]
    }
    return $result
} returns {
    fromAddress
}
<ws>namespace finalize ::address
<ws>return ::address