#!/usr/bin/awk -f

BEGIN {
	rcnt = 0
}
/^SIA:/ {
	ts = sprintf("%s %s %02d %s", $2, $3, $4, $5)
	records[rcnt, "timestamp"] = ts
	# get the event line
	getline
	if ( NF < 8 || NF > 9 )
		next

	if ( NF == 8 && $4 == "su" ) {
		records[rcnt, "fromuser"] = $6
		records[rcnt, "touser" ] = $8
		rcnt++
	} else
		next
}

END {
	for ( i = 0 ; i < rcnt ; i++ ) {
		printf("%s From: %s To: %s\n",
			   records[i, "timestamp"],
			   records[i, "fromuser"],
			   records[i, "touser"])
	}
}

