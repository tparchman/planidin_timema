#!/bin/bash

##########################################################################################
## FRLA2 cleaning 
##########################################################################################

/working/jahner/tapioca/src/tap_contam_analysis --db  /archive/parchman_lab/rawdata_to_backup/contaminants/illumina_oligos --pct 20 /working/parchman/FRLA/FRLA2_S2_L002_R1_001.fastq > FRLA2.readstofilter.ill.txt 

echo "Illumina filtering done for lane 1"

/working/jahner/tapioca/src/tap_contam_analysis --db /archive/parchman_lab/rawdata_to_backup/contaminants/phix174 --pct 80 /working/parchman/FRLA/FRLA2_S2_L002_R1_001.fastq > FRLA2.readstofilter.phix.txt 

echo "PhiX filtering done for lane 1"


/working/jahner/tapioca/src/tap_contam_analysis --db  /archive/parchman_lab/rawdata_to_backup/contaminants/ecoli-k-12 --pct 80 /working/parchman/FRLA/FRLA2_S2_L002_R1_001.fastq > FRLA2.readstofilter.ecoli.txt

echo "ecoli filtering done for lane 1"


cat /working/parchman/FRLA/FRLA2_S2_L002_R1_001.fastq | fqu_cull -r FRLA2.readstofilter.ill.txt FRLA2.readstofilter.phix.txt FRLA2.readstofilter.ecoli.txt > FRLA2.clean.fastq

echo "Clean copy of lane 1 done"

