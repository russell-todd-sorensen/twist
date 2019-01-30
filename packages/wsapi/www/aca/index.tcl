<ws>namespace delete ::aca 
<ws>namespace init ::aca
<ws>namespace schema aca "company:division:grp"

set exampleFileName "1094B_Request_BZDHT_20191231T235959999Z.xml"

set    patternFileName {1094[B|C]_Request_}         ;# 1094B_Request_
append patternFileName {[B-DF-HJ-NP-TVZ]{2}}        ;# BZ
append patternFileName {[B-DF-HJ-NP-TV-Z0-9]{3}}    ;# DHT
append patternFileName {_[1-9][0-9]{3}}             ;# _2019
append patternFileName {(0[1-9]|1[0-2])}            ;# 12
append patternFileName {(0[1-9]|[1-2][0-9]|3[0-1])} ;# 31
append patternFileName {T(0[0-9]|1[0-9]|2[0-3])}    ;# T23
append patternFileName {(0[0-9]|[1-5][0-9])}        ;# 59
append patternFileName {(0[0-9]|[1-5][0-9])}        ;# 59
append patternFileName {[0-9]{3}Z\.xml}             ;# 999Z.xml

<ws>type pattern aca::PaymentYrType {[1-9][0-9]{3}}
<ws>type enum aca::PriorYearDataIndType {0 1}
<ws>type pattern aca::EINType {[0-9]{9}}
<ws>type enum aca::TransmissionTypeCdType {O C R}
<ws>type pattern aca::TestFileCdType {([TP])?}
<ws>type stringRestrict aca::OriginalReceiptIdType {maxLength 80}
<ws>type enum aca::TransmitterForeighEntityIndType {0 1}
<ws>type decimalRestrict aca::TotalPayeeRecordCntType {minInclusive 0} xsd::integer
<ws>type decimalRestrict aca::TotalPayerRecordCntType {minInclusive 1} xsd::integer
<ws>type stringRestrict aca::SoftwareIdType {maxLength 10}
<ws>type enum aca::FormTypeCdType {1094/1095B 1094/1095C}
<ws>type enum aca::BinaryFormatCdType {application/xml}
<ws>type pattern aca::ChecksumAugmentationNumType {[0-9A-Fa-f]{64}}
<ws>type decimalRestrict aca::AttachmentByteSizeNumType {minInclusive 0} xsd::integer
<ws>type pattern aca::DocumentSystemFileNmType $patternFileName

set    IDSFileNamePattern {(EOM|EOY)_(Request|Response)}
append IDSFileNamePattern {_(0000[1-9]|000[1-9][0-9]|00[1-9][0-9][0-9]|0[1-9][0-9][0-9][0-9]|[1-9][0-9][0-9][0-9][0-9])}
append IDSFileNamePattern {_[1-9][0-9]{3}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])}
append IDSFileNamePattern {T(0[1-9]|1[0-9]|2[0-3])(0[1-9]|[1-5][0-9])(0[1-9]|[1-5][0-9])[0-9]{3}}
append IDSFileNamePattern {Z_[1-9][0-9]{3}\-.+T[^\.]+(Z|[\+\-].+)_[0-9]{8}\.xml}

<ws>type pattern aca::InternalDocumentSystemFileNameType $IDSFileNamePattern

<ws>type pattern aca::ExchangeIdType {[0-9]{2}\.[a-zA-Z]{2}[a-zA-Z*]{1}\.[a-zA-Z0-9]{3}\.[0-9]{3}\.[0-9]{3}}
<ws>type enum aca::EPDSubmissionSourceCdType {Individual Shop}
<ws>type pattern aca::ExemptionCertificateNumType {[a-hA-H]{1}[a-zA-Z0-9]{5}[NYny]{1}}
<ws>type enum aca::FileSourceCodeType {1 2 3 4 5 6 7 8 9 0}
<ws>type enum aca::FileStatusCdType {Rejected Delivered-Success Delivered-Exception Delivery-Failed}
<ws>type decimalRestrict aca::IdentifierType {totalDigits 16} xsd::integer
<ws>type enum aca::IndicatorCodeType {Y N}
<ws>type simple aca::IntegerNNType xsd::nonNegativeInteger


<ws>proc ::aca::hello {} {
    return Hello
} returns {string}

<ws>proc ::aca::checkFileName {testString} {
    return [$::wsdb::types::aca::DocumentSystemFileNmType::validate $testString]
} returns {isValid:boolean}

set CheckReturnType {
    {Value:string {minOccurs 1}}
    {IsValid:boolean {minOccurs 1}}
}

<ws>element sequence aca::CheckTotalPayerResponse $CheckReturnType 
<ws>element sequence aca::CheckTotalPayeeResponse $CheckReturnType

<ws>proc ::aca::CheckTotalPayer {testString} {
    return [list $testString [$::wsdb::types::aca::TotalPayerRecordCntType::validate $testString]]
} returns { }

<ws>proc ::aca::CheckTotalPayee {testString} {
    return [list $testString [$::wsdb::types::aca::TotalPayeeRecordCntType::validate $testString]]
} returns { }

<ws>namespace finalize ::aca
<ws>return ::aca