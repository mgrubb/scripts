#!/usr/bin/ksh
# script for CUPS to print to files in a particular directory
# I got this somewhere, but can't recall where now.

# test for 5 or 6 params
FILE=${6:-"-"}
LOG=/tmp/receiptprint.log
export LOG
JOBID=$1
USER=$2
TITLE=$3
COPIES=$4
OPTIONS=$5
PID=$$
cat >> ${LOG} << EOF
${FILE}:
      JOBID: ${JOBID}
       USER: ${USER}
      TITLE: ${TITLE}
     COPIES: ${COPIES}
    OPTIONS: ${OPTIONS}

EOF

# if there are no arguments: print "I'm here" message for cupsd's probing
if [ $# -eq 0 ] ; then
	echo "direct receiptprint \"Unknown\" \"Print any job to file specified in device-URI\""
	exit 0
fi

if [ $# -ne 5 -a $# -ne 6 ] ; then
	cat << EOF

Usage: receiptprint job-id user title copies options [file]
examples for device-URI: 'receiptprint:/path/to/targetfile'
(this writes the printfile to disk at specified path)

Install a printqueue with 'lpadmin -p <receipt-printer-name> -v receiptprint:/<path/to/targetfile> -E [-P /path/to/PPD]

EOF
exit 1
fi

# sanitize $TITLE -- remove any spaces, colons and slashes or
# backslashes from filename
TITLE=`echo ${TITLE} | tr [:blank:] _ | tr : _ | tr / _ | tr "\134" _`
TARGETFILE=${DEVICE_URI#receiptprint:}

# For adding extra info into filename
#TARGETFILE=${DEVICE_URI#receiptprint:}-${TITLE}-${JOBID}-${USER}

# check "accepting" status first
GREPSTRING="not accepting"
if lpstat -a ${TARGETFILE} | grep "${GREPSTRING}" &> /dev/null ; then
	echo "ERROR: printer ${TARGETFILE} not acceptings jobs..."
	exit 1
fi

cat ${FILE} > ${TARGETFILE}

echo "INFO: printed receipt..." >&2

exit 0
