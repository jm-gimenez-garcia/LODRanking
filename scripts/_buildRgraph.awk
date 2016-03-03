#!/usr/bin/awk -f

BEGIN {
	# Initializing function
	graph_from_literal = "graph_from_literal("
}

#Adding a directed edge from $1 to $2
!x[$0]++ {graph_from_literal "\"$1\" -+ \"$2\","}

END {
	#Removing last comma and closing the function parenthesis
	graph_from_literal = gsub(/,$/,"",graph_from_literal) ")"
}