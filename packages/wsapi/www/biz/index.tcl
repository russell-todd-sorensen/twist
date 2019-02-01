<ws>namespace init ::biz

<ws>namespace schema ::biz "http://biz.semitasker.com/biz/"

<ws>element sequence biz::address {
    {Id:xsd::integer}
    {Name:xsd::string}
    {LineOne:xsd::string}
    {LineTwo:xsd::string}
    {City:xsd::string}
    {State:xsd::string}
    {Zipcode:xsd::string}
}

<ws>element sequence biz::item {
    {Line:xsd::integer}
    {PartNum:xsd::string}
    {Description:xsd::string}
    {Quantity:xsd::integer}
}

<ws>element sequence biz::items {
    {Item:elements::biz::item {maxOccurs 10}}
}

<ws>element sequence biz::invoice {
    {Id:xsd::integer}
    {MailAddress:elements::biz::address}
    {ShipAddress:elements::biz::address}
    {Items:elements::biz::items}
}

<ws>proc biz::EchoInvoice EchoInvoiceRequest:elements::biz::invoice {
    return $Invoice
} returns EchoInvoiceResponse:elements::biz::invoice

<ws>namespace finalize ::biz

<ws>return ::biz