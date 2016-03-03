#!/usr/bin/awk -f

{
	for (field = 1; field < NF; field++) {
		if (field == 2) {continue}
		if ($field != "." && $field != $NF) {printf "%s %s\n",$NF,$field}
	}
}