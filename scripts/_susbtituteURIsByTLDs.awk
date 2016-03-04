#!/usr/bin/awk -f

BEGIN {
    if (ARGC != 3)
    {
            printf "Usage %s ccSLD_file quads_file \n",ARGV[0] > "/dev/stderr";
            exit 1
	}
	regex_pld = ""
	regex_domain = ":\\/\\/([^\\/]+)\\/"
}

(NR == FNR) {
	if ($1 != "//" && $1 != "") {
		#gsub(/\./, "\\\.");
		regex_pld = regex_pld $1 "|"
	}
}

ENDFILE {
	regex_pld = "([^\\/\\.]+\\.(" substr(regex_pld,1,length(regex_pld)-1) "))\\/";
		}

(NR != FNR) {
	line = "";

	# For all fields except the last one (the named graph) look for PLD
	for (field = 1; field < NF; field++) {
		numchar = match($field,regex_pld,replacement);
		if (numchar > 0) {$field = replacement[1] " "}
		else {$field = "."}
	}

	# For the las field (the named graph), take PLD if possible, complete domain if not
	numchar = match($NF,regex_pld,replacement);
	if (numchar > 0) {$NF = replacement[1] " "}
	else {
		match($NF,regex_domain,replacement);
		$NF = replacement[1];
	}

	print
}
