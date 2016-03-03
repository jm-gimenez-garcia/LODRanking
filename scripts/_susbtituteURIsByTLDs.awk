#!/usr/bin/awk -f

BEGIN {
    if (ARGC != 3)
    {
            printf "Usage %s ccSLD_file quads_file \n",ARGV[0] > "/dev/stderr";
            exit 1
	}
	regex = ""
}

(NR == FNR) {
	if ($1 != "//" && $1 != "") {
		#gsub(/\./, "\\\.");
		regex = regex $1 "|"
	}
}

ENDFILE {
	regex = ":\\/\\/([^\\/\\.]+\\.(" substr(regex,1,length(regex)-1) "))\\/";
		}

(NR != FNR) {
	line = "";
	for (field = 1; field <= NF; field++) {
		numchar = match($field,regex,replacement);
		if (numchar > 0) {$field = replacement[1] " "}
		else {$field = "."}
	}
	print
}
