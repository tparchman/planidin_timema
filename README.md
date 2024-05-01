# Timema 2023 GBS
# Organization and Workflow for *Timema* 2023 GBS - Planidin PhD set 
Organizational notes and code for two libraries spanning 12 plates, also includes some spider DNAs from Vanina


## Sample organization
- Sample information with plate map is in `2022_NPPandVT_plates.xlsx`.

- barcode key files correspond with LIB1 (plates 1-6; `T231_barcode_key.csv`) and LIB2 (plates 7-12; `T231_barcode_key.csv`).

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

Being executed on ponderosa using tapioca pipeline. Commands in two bash scripts (cleaning_bash_CADE_FRVE.sh), executed as below (4/12/24). This work being carried out at:

    /working/parchman/CADE_FRVE/

Decompress fastq files:

    $ gunzip CADE-FRVE_S1_L001_R1_001.fastq.gz
    $ gunzip CADE-FRVE_S1_L002_R1_001.fastq.gz

Number of reads **before** cleaning:

    $ nohup grep -c "^@" CADE-FRVE_S1_L001_R1_001.fastq > L001_number_of_rawreads.txt &
    ## raw reads: 

    $ nohup grep -c "^@" CADE-FRVE_S1_L002_R1_001.fastq > L002_number_of_rawreads.txt &
    ## raw reads: 
To run cleaning_bash* tapioca wrapper, exit conda environment, load modules, and run bash scripts.

    $ module load fqutils/0.4.1
    $ module load bowtie2/2.2.5
    
    $ bash cleaning_bash_CADE_FRVE.sh &


After .clean.fastq has been produced, rm raw data:

    $ rm -rf CADE-FRVE_S1_L001_R1_001.fastq &
    $ rm -rf CADE-FRVE_S1_L002_R1_001.fastq &



Raw data will stay stored in: /archive/parchman_lab/rawdata_to_backup/FRLA/

Number of reads **after** cleaning:

    $ nohup grep -c "^@" CADE_FRVE1.clean.fastq > CADE_FRVE1_clean_reads.txt &
    # number of clean reads : 

    $ nohup grep -c "^@" CADE_FRVE2.clean.fastq > CADE_FRVE2_clean_reads.txt &
    # number of clean reads : 

####################################################################################
## 2. Barcode parsing:
####################################################################################

Be sure to deactivate conda environment before running the below steps. Barcode keyfiles are `/working/parchman/TEPE23/FRLA1_barcode_key.csv`
`
Parsing CADE_FRVE1 library:

    $ nohup perl parse_barcodes768.pl CADE_FRVE_barcode_info_2018.csv CADE_FRVE1.clean.fastq A00 &>/dev/null &

Parsing CADE_FRVE2 library:

    $ nohup perl parse_barcodes768.pl CADE_FRVE_barcode_info_2018.csv CADE_FRVE2.clean.fastq A00 &>/dev/null &

`NOTE`: the A00 object is the code that identifies the sequencer (first three characters after the @ in the fastq identifier).

    $ less parsereport_CADE_FRVE1.clean.fastq

    Good mids count: 644098458
    Bad mids count: 25913131
    Number of seqs with potential MSE adapter in seq: 197210
    Seqs that were too short after removing MSE and beyond: 190

    $ less parsereport_CADE_FRVE2.clean.fastq

    Good mids count: 668825901
    Bad mids count: 47552067
    Number of seqs with potential MSE adapter in seq: 648922
    Seqs that were too short after removing MSE and beyond: 4257

####################################################################################
## 3. splitting fastqs
####################################################################################

For FRLA, doing this in `/working/parchman/CADE_FRVE/splitfastqs_CADE_FRVE/` 

Concatenate the two parsed_*fastq files:

    $ nohup cat parsed_CADE_FRVE1.clean.fastq parsed_CADE_FRVE2.clean.fastq > cat_parsed_CADE_FRVE12.clean.fastq &>/dev/null &

Make ids file

    $ cut -f 3 -d "," CADE_FRVE_barcode_info_2018.csv | grep "[A-Z]" > CADE_FRVE_ids_noheader.txt


Split fastqs by individual

    $ nohup perl splitFastq_universal_regex.pl CADE_FRVE_ids_noheader.txt cat_CADE_FRVE_1and2.fastq &>/dev/null &



# DONE TO HERE &&&&&&&&&&


Zip the parsed*fastq files for now, but delete once patterns and qc are verified.

### Moving fastqs to project specific directories
