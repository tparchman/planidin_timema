# fraxinus_latifolia
# Organization and Workflow for *Fraxinus latifolia* GBS 
Organizational notes and code for two sequencing sets:
- rangewide sampling for landscape genomic analyses
- sequencing of indivuals from provenance trials

# Range-wide landscape genomics: sample organization and GBS workflow 

## Sample organization
- Full information on DNAs for each individual sampled across natural distribution can be found in `2022_FRALAT_NaturalPopulations_RADSeq_Sequencing_PlateDesign_TParchman_sharable.xlsx`. This file also has the updated plate maps with specified IDs.

- barcode key files correspond with LIB1 (plates 1-6; `barcode_info_FRALAT_NaturalPopulations_Plate1-6.csv`) and LIB2 (plates 7-12; `barcode_info_FRALAT_NaturalPopulations_Plate7-12.csv`).

- **NOTE** I added 32 samples (4 plate columns) of *Pinus rigida* DNAs from Connie Bolte to plate 12. Thus, plate 12 now has 10 columns of DNAs, rather than 6. The *P. rigida* PCR product will be diluted 2 fold compared to *Fraxinus* for the final libraries.

## GBS workflow

- All organizational information, and notes on lab workflow are in `GBS_rangewide/` .

## Notes on library preparation

**NEED TO DO**: anneal more MSE adaptors, order iproof (have martinson order a tube), order ladder

### 12/19-12/22: R/L and PCR for plates 1-6. Master mix in `FRAXONE_RFseq_mastermixcockatils.xlsx`.

12/23/22: gel for FRLA_LIB1
 
![GELIMAGE](md_images/FRLA_LIB1_GEL.jpg)

10 ul of each PCR product into final library. Tubes in door of freezer labelled **FRLA_LIB1**.

12/28 - 12/31: R/L and PCR for plates 7-12. Master mix in `FRAXTWO_RFseq_mastermixcockatils.xlsx`. Note, plate 12 is 85% full, and contains 4 columns of *P. rigida* DNAs from Connie Bolte.

12/31/22: gel for FRLA_LIB2
 
![GELIMAGE](md_images/FRLA2_gel.jpg)

10 ul of each PCR product into final library. Tubes in door of freezer labelled **FRLA_LIB2**.

# DONE TO HERE ###################


## Data analysis: contaminant cleaning, barcode parsing, data storage.