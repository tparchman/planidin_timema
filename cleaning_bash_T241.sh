#!/bin/bash

##########################################################################################
## FRLA1 cleaning 
##########################################################################################

/working/parchman/tapioca/src/tap_contam_analysis --db  /Pedro/parchman_lab/rawdata_to_backup/contaminants/illumina_oligos --pct 20 /working/parchman/T241and2/T23-1_S1_L001_R1_001.fastq > T24_1.readstofilter.ill.txt 

echo "Illumina filtering done for lane 1"

/working/parchman/tapioca/src/tap_contam_analysis --db /Pedro/parchman_lab/rawdata_to_backup/contaminants/phix174 --pct 80 /working/parchman/T241and2/T23-1_S1_L001_R1_001.fastq > T24_1.readstofilter.phix.txt 

echo "PhiX filtering done for lane 1"


/working/parchman/tapioca/src/tap_contam_analysis --db  /Pedro/parchman_lab/rawdata_to_backup/contaminants/ecoli-k-12 --pct 80 /working/parchman/T241and2/T23-1_S1_L001_R1_001.fastq > T24_1.readstofilter.ecoli.txt

echo "ecoli filtering done for lane 1"


cat /working/parchman/T241and2/T23-1_S1_L001_R1_001.fastq | fqu_cull -r T24_1.readstofilter.ill.txt T24_1.readstofilter.phix.txt T24_1.readstofilter.ecoli.txt > T24_1.clean.fastq

echo "Clean copy of lane 1 done"

