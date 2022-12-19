#!/bin/bash
# import "querystring@1.3.0"
import "https://gist.githubusercontent.com/widhisec/e64a8b7116ae9b2ef664ad5bbaa04788/raw/3d291cf56b1127e542ff1cab979c30540ebeba04/gistfile1.txt"
# handler() {
# http_response_header "Content-Type" "text/html; charset=utf8"
#     local path="$(jq -r '.path' < "$1")"
#     local query="$(querystring "$path"|querystring_unescape)"
#      local _username=$(curl -skL "$query")
#      local _okey=$(echo -e $_username|grep -Po '(?<=username":")[^"]*')
# 	#echo "Querystring is: $query"
# 	echo "$_username"
# cat << 'EOF'
# <!DOCTYPE html>
# <html>
#   <head>
#     <meta name="viewport" content="width=device-width, initial-scale=1.0">
#     <!-- Bootstrap -->
#     <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" media="screen">

#     <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
#     <!--[if lt IE 9]>
#       <script src="../../assets/js/html5shiv.js"></script>
#       <script src="../../assets/js/respond.min.js"></script>
#     <![endif]-->
#   </head>
#   <body>
#     <h1>Hello, world!</h1>
#     <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
#     <script src="//code.jquery.com/jquery.js"></script>
#     <!-- Include all compiled plugins (below), or include individual files as needed -->
#   </body>
# </html>
# EOF
	
# }
handler() {
      poll_msg | msg_handler 
}
