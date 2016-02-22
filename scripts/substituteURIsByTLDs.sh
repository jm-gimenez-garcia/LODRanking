#!/usr/bin/env bash

./substituteDocsByURIs.sh | ./_susbtituteURIsByTLDs.awk ../data/public_suffix_list.dat -