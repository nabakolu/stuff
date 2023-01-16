#!/bin/sh
#
File="$HOME/.config/streamers"
Lines=$(cat "$File")
Streamers="abort"
Code=`cat <<EOF
import requests, sys
# ...
def checkIfUserIsStreaming(username):
  url = "https://gql.twitch.tv/gql"
  query = "query {\n  user(login: \""+username+"\") {\n    stream {\n      id\n    }\n  }\n}"
  return True if requests.request("POST", url, json={"query": query, "variables": {}}, headers={"client-id": "kimne78kx3ncx6brgo4mv6wki5h1ko"}).json()["data"]["user"]["stream"] else False

if checkIfUserIsStreaming(sys.argv[1]):
    sys.exit(0)
else:
    sys.exit(1)
EOF`
for Line in $Lines
do
    python3 -c "$Code" "$Line" && Streamers="${Streamers}
$Line"
done

Choice=$(echo "$Streamers" | dmenu)
[ "$Choice" = "abort" ] || [ "$Choice" = "" ] || mpv "https://twitch.tv/${Choice}"

