# Timema 2023 GBS
# Organization and Workflow for *Timema* 2023 GBS - Planidin PhD set 
Organizational notes and code for two libraries spanning 12 plates, also includes some spider DNAs from Vanina


## Sample organization
- Sample information with plate map is in `2022_NPPandVT_plates.xlsx`.

- barcode key files correspond with LIB1 (plates 1-6; `T231_barcode_key.csv`) and LIB2 (plates 7-12; `T232_barcode_key.csv`).

- **NOTE** 

## GBS workflow

- All organizational information, and notes on lab workflow are in `/Documents/GitHub/planidin_timema/README.md`.

## Notes on library preparation

**NEED TO DO**: anneal more MSE adaptors, order iproof (have martinson order a tube), order ladder

### 3/23-4/19: R/L and PCR for plates 1-6. Master mix in `timema23_RFseq_mastermixcockatils.xlsx`.

4/19/23: gel for T23_LIB1
 
![GELIMAGE](md_images/T23__LIB1_GEL.jpg)


# Done to here
10 ul of each PCR product into final library. Tubes in door of freezer labelled **T23_LIB1**.

12/28 - 12/31: R/L and PCR for plates 7-12. Master mix in `FRAXTWO_RFseq_mastermixcockatils.xlsx`. Note, plate 12 is 85% full, and contains 4 columns of *P. rigida* DNAs from Connie Bolte.

12/31/22: gel for FRLA_LIB2
 
![GELIMAGE](md_images/FRLA2_gel.jpg)

10 ul of each PCR product into final library. Tubes in door of freezer labelled **FRLA_LIB2**.

# DONE TO HERE ###################


## Data analysis: contaminant cleaning, barcode parsing, data storage.

## 1. Cleaning contaminants

Being executed on ponderosa using tapioca pipeline. Commands in two bash scripts (cleaning_bash_T241.sh and cleaning_bash_T242.sh), executed as below (6/6/24). This work being carried out at:

    /working/parchman/T241and2/

Decompress fastq files:

    $ gunzip T23-1_S1_L001_R1_001.fastq.gz
    $ gunzip T23-2_S2_L002_R1_001.fastq.gz

Number of reads **before** cleaning:

    $ nohup grep -c "^@" T23-1_S1_L001_R1_001.fastq > T231_number_of_rawreads.txt &
    ## raw reads: 

    $ nohup grep -c "^@" T23-2_S2_L002_R1_001.fastq > T232_number_of_rawreads.txt &
    ## raw reads: 

To run cleaning_bash* tapioca wrapper, exit conda environment, load modules, and run bash scripts.

    $ module load fqutils/0.4.1
    $ module load bowtie2/2.2.5
    
    $ bash cleaning_bash_T241.sh &
    $ bash cleaning_bash_T242.sh &

After .clean.fastq has been produced, rm raw data:

    $ rm -rf CADE-FRVE_S1_L001_R1_001.fastq &
    $ rm -rf CADE-FRVE_S1_L002_R1_001.fastq &

Raw data will stay stored in: /backups/parchman_lab/rawdata_to_backup/FRLA/

Number of reads **after** cleaning:

    $ nohup grep -c "^@" T24_1.clean.fastq > T24_1_clean_reads.txt &
    # number of clean reads : 

    $ nohup grep -c "^@" T24_2.clean.fastq > T24_2_clean_reads.txt &
    # number of clean reads : 

####################################################################################
## 2. Barcode parsing:
####################################################################################

Be sure to deactivate conda environment before running the below steps. Barcode keyfiles are `/working/parchman/T241and2/T231_barcode_key.csv` and `T232_barcode_key.csv`
`
Parsing CADE_FRVE1 library:

    $ nohup perl parse_barcodes768.pl T231_barcode_key.csv T24_1.clean.fastq A00 &>/dev/null &

Parsing CADE_FRVE2 library:

    $ nohup perl parse_barcodes768.pl T232_barcode_key.csv T24_2.clean.fastq A00 &>/dev/null &

`NOTE`: the A00 object is the code that identifies the sequencer (first three characters after the @ in the fastq identifier).

    $ less parsereport_T24_1.clean.fastq

    Good mids count: 1274342213
    Bad mids count: 132040568
    Number of seqs with potential MSE adapter in seq: 414213
    Seqs that were too short after removing MSE and beyond: 670

    $ less parsereport_T24_2.clean.fastq

    Good mids count: 1392943740
    Bad mids count: 141991829
    Number of seqs with potential MSE adapter in seq: 662591
    Seqs that were too short after removing MSE and beyond: 523

####################################################################################
## 3. splitting fastqs
####################################################################################

doing this in `/working/parchman/T241and2/splitfastqsT1` and `/working/parchman/T241and2/splitfastqsT1`

Make ids file

    $ cut -f 3 -d "," T231_barcode_key.csv | grep "[A-Z]" > T231_ids_noheader.txt

    $ cut -f 3 -d "," T232_barcode_key.csv | grep "[A-Z]" > T232_ids_noheader.txt

Split fastqs by individual

    $ nohup perl splitFastq_universal_regex.pl T231_ids_noheader.txt parsed_T24_1.clean.fastq &>/dev/null &

    $ nohup perl splitFastq_universal_regex.pl T232_ids_noheader.txt parsed_T24_2.clean.fastq &>/dev/null &

# DONE TO HERE &&&&&&&&&&


Zip the parsed*fastq files for now, but delete once patterns and qc are verified.

### Moving fastqs to project specific directories
