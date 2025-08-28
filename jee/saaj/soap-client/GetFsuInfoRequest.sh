#!/usr/bin/env bash

PRG=$(readlink -f $0)
PRG_DIR=$(dirname "${PRG}")
HOME_DIR=$(dirname "${PRG_DIR}")


FSU_ID=""
FSU_URL=""

function print_usage() {
  cat << EOF
Usage: <cmd> <options>
valid options are:
  -f, --fsu-id <fsu id>
  -l, --fsu-url <fsu url>
  -h, --help
EOF
}

function print_options() {
  cat << EOF
current options are:
  -f, --fsu-id="${FSU_ID}"
  -l, --fsu-url="${FSU_URL}"
EOF
}

if [[ $# -eq 0 ]]
then
  print_usage; exit -1;
fi

OPTS=$(getopt -of:l:h:: --long fsu-id:,fsu-url:,help -- $@)

if [[ $? -eq 0 ]]
then
  while true; do
    case "$1" in
      -f | --fsu-id)
        FSU_ID="$2"; shift 2;;
      -l | --fsu-url)
        FSU_URL="$2"; shift 2;;
      -h | --help)
        print_usage; exit -1;;
      *) break;;
    esac
  done
else
  print_usage;
  exit -1;
fi

if [[ "${#FSU_ID}" -eq 0 ]]
then
  echo "--fsu-id is empty."
  exit -1;
fi

if [[ "${#FSU_URL}" -eq 0 ]]
then
  echo "--fsu-url is empty."
  exit -1;
fi

print_options

REQUEST_DATA=$(cat << EOF
<?xml version="1.0" encoding="utf-8" ?>
<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
  <SOAP-ENV:Body SOAP-ENV:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
    <ns1:invoke xmlns:ns1="http://FSUService.chinamobile.com">
      <xmlData xmlns:SOAP-ENC="http://schemas.xmlsoap.org/soap/encoding/" xsi:type="SOAP-ENC:string">&lt;?xml version="1.0" encoding="UTF-8" standalone="yes"?&gt;
         &lt;Request&gt;
           &lt;PK_Type&gt;
             &lt;Name&gt;GET_FSUINFO&lt;/Name&gt;
           &lt;/PK_Type&gt;
           &lt;Info&gt;
             &lt;FSUID&gt;${FSU_ID}&lt;/FSUID&gt;
           &lt;/Info&gt;
         &lt;/Request&gt;
      </xmlData>
    </ns1:invoke>
  </SOAP-ENV:Body>
</SOAP-ENV:Envelope>
EOF
)

echo "==============================================================================="
echo "${REQUEST_DATA}"
echo "-------------------------------------------------------------------------------"
curl -v \
  -H 'Content-Type: text/xml' \
  -H 'SOAPAction: ""' \
  -H 'Connection: close' \
  -d "${REQUEST_DATA}" \
  "${FSU_URL}"
echo "-------------------------------------------------------------------------------"
