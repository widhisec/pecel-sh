#!/bin/bash
# import "querystring@1.3.0"
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
#!/bin/bash

# bot configuration
TOKEN='5663841895:AAG559KWxEIH8WXSO7ApxhiZWmfegJb-H3Y'
URL='https://api.telegram.org/bot'$TOKEN
INTV=1

# log: logger
# usage: log <loglevel> <message>
# loglevel: integer, 1 to 3, INFO/DEBUG/VERBOSE
# message: log message
# return: none
LOGLEVELS=(NONE INFO DEBUG VERBOSE)
function log {
	[[ $1 -lt ${LOGLEVEL:-0} ]] && printf "%8s %-72s\n" "${LOGLEVELS[$1]}" "$(date) - $2" >&2
}

# msg_send: send message
# usage：msg_send <chat_id> <message> [extra_args] 
# chat_id: chat_id
# message: message
# extra_args: extra args to pass to curl. (e.g. -F "parse_mode=Markdown")
# return: none
function msg_send {
	log 1 "send \"$2\" to $1"
	log 2 "sendMessage respond: $(curl -s "$URL/sendMessage" -F "chat_id=$1" -F "text=$2" $3)"
}

# poll_msg: poll message from botAPI
# usage: poll_msg
# return: message object stream.
function poll_msg {
	while true
	do
		log 3 "polling message."
		objs="$(curl -s "$URL/getUpdates?offset=${offset:-0}" | jq -c '.result []')"
		[[ ! -z $objs ]] && log 2 "getUpdates got object(s): $objs"
		offset="$(($(jq '.update_id' <<< "$objs" | tail -n1) + 1))"
		log 3 "next offset: $offset"
		jq -c '.message' <<< "$objs"
		log 3 "wait for $INTV second(s)."
		sleep $INTV
	done
}

# msg_handler: handle message object from stdin.
# usage: msg_handler
# return none
function msg_handler {
	while read -r line
	do 
		log 2 "handler got message object: $line"
		jq -r '.chat .id, .text' <<< "$line" | while read -r chat_id
		do
			read -r msg
			log 1 "get \"$msg\" from $chat_id"
			msg_send "$chat_id" "$msg"
		done
	done
}

# bot body. do poll_msg and pipe it into message handler.
poll_msg | msg_handler 
}	
