# LODRanking
## (Work in progress)

Tool for extracting and ranking datasets from the LOD Laundromat.

Steps
1. run "scripts/fetchUrisFromLODLaundromat.sh > ../data/documents+uris.txt" to create file containing all LODLaundromat documents and associated URIs.
2. run "scripts/substituteURIsByPLDs.sh > ../data/TLDquads" to create file with all LODLaundromat quads, where each term is replaced by its PLD if applicable, or . if not.
