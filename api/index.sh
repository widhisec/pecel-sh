#!/bin/bash
import "querystring@1.3.0"
handler() {
http_response_header "Content-Type" "text/html; charset=utf8"
    local path="$(jq -r '.path' < "$1")"
    local query="$(querystring "$path"|querystring_unescape)"
     local _username=$(curl -skL "$query")
     local _okey=$(echo -e $_username|grep -Po '(?<=username":")[^"]*')
	#echo "Querystring is: $query"
	echo "$_okey"
	echo "$(docker run --rm -it amazonlinux:2.0.20191217.0 sh)"
	echo "$(amazon-linux-extras install php7.4)"	
}
