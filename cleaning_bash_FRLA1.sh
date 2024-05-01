#!/bin/bash

##########################################################################################
## FRLA1 cleaning 
##########################################################################################

/working/jahner/tapioca/src/tap_contam_analysis --db  /archive/parchman_lab/rawdata_to_backup/contaminants/illumina_oligos --pct 20 /working/parchman/FRLA/FRLA1_S1_L001_R1_001.fastq > FRLA1.readstofilter.ill.txt 

echo "Illumina filtering done for lane 1"

/working/jahner/tapioca/src/tap_contam_analysis --db /archive/parchman_lab/rawdata_to_backup/contaminants/phix174 --pct 80 /working/parchman/FRLA/FRLA1_S1_L001_R1_001.fastq > FRLA1.readstofilter.phix.txt 

echo "PhiX filtering done for lane 1"


/working/jahner/tapioca/src/tap_contam_analysis --db  /archive/parchman_lab/rawdata_to_backup/contaminants/ecoli-k-12 --pct 80 /working/parchman/FRLA/FRLA1_S1_L001_R1_001.fastq > FRLA1.readstofilter.ecoli.txt

echo "ecoli filtering done for lane 1"


cat /working/parchman/FRLA/FRLA1_S1_L001_R1_001.fastq | fqu_cull -r FRLA1.readstofilter.ill.txt FRLA1.readstofilter.phix.txt FRLA1.readstofilter.ecoli.txt > FRLA1.clean.fastq

echo "Clean copy of lane 1 done"

