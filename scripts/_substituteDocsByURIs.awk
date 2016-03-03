#!/usr/bin/awk -f

BEGIN {
        if (ARGC != 3)
        {
                printf "Usage %s dictionary_file quads_file \n",ARGV[0] > "/dev/stderr";
                exit 1
		}
}

(NR == FNR) {dict["<" $1 ">."] = "<" $2 ">.";}

(NR != FNR) {
		$NF = dict[$NF];
		print
}