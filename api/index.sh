#!/bin/bash
import "querystring@1.3.0"
handler() {
http_response_header "Content-Type" "text/html; charset=utf8"
     local _username=$(curl -sk "$1")
     local _okey=$(echo -e $_username|grep -Po '(?<=username":")[^"]*')
     local path
	local query
	path="$(jq -r '.path' < "$1")"
	query="$(querystring "$path")"
	echo "Querystring is: $query"
	echo "${_okey}"
cat << 'EOF'
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" media="screen">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="../../assets/js/html5shiv.js"></script>
      <script src="../../assets/js/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>
    <h1>Hello, world!</h1>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="//code.jquery.com/jquery.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
  </body>
</html>
EOF
	
}
