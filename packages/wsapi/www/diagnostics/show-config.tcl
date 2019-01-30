set config ""

foreach section [ns_configsections] {

    append config "</ul>\n<ul><b>[ns_set name $section]</b>\n"

    foreach {key value} [ns_set array $section] {
         append config "<li> $key: $value</li>\n"
    }
}

ns_return 200 text/html "<!DOCTYPE html>
<html charset='utf-8'>
<head>
<title>Config for [ns_info server]</title>
</head>
<body>

 $config

</body>
</html>"