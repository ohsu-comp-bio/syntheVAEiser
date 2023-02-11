# synthesis

## Aquire data from UC Santa Cruz Xena Browser

Dataset Page:
https://xenabrowser.net/datapages/?dataset=TCGA-BRCA.htseq_fpkm-uq.tsv&host=https%3A%2F%2Fgdc.xenahubs.net&removeHub=https%3A%2F%2Fxena.treehouse.gi.ucsc.edu%3A443

Dataset:
https://gdc-hub.s3.us-east-1.amazonaws.com/download/GDC-PANCAN.htseq_fpkm-uq.tsv.gz

Pam50 Labels Page:
https://xenabrowser.net/datapages/?dataset=brca%2Fpam50&host=https%3A%2F%2Fatacseq.xenahubs.net&removeHub=https%3A%2F%2Fxena.treehouse.gi.ucsc.edu%3A443

Labels download link:
https://tcgaatacseq.s3.us-east-1.amazonaws.com/download/brca%2Fpam50

clone this repo and place the downloaded data files in the root of this repo
rename the data file to whatever you want, in this case it was renamed to big_data.tsv.gz.

the labels file stayed its default download name brca_pam50

To run through an example process of this tool do preprocess -> train -> (gen_decoded or gen_synth) -> UMAP (any 2 tsvs with the same label column name) 
or if the labels have already been integrated into the file in the 2nd column, since the first column is sample names, then you will not need to run preprocess command

## Run the below command to preprocess the dataset

```
./synthesis preprocess big_data.tsv.gz -t --label-file brca_pam50 --label-col PAM50
```

-t -> transpose the entire dataset so that samples are rows and columns are features

--label-file -> the name of the 

--label-col -> the name of the column that holds the labels to generate synthentic samples for

This command can take a couple minutes+ on multigigabyte files because read times are slow

## Run the below command to train an encoder/decoder from formatted data

NOTE you will have to tune your dataset with optional hyperparamaters arguments 
to get the decoded data to be in the same ballpark as the data you use to train your models.
You can measure how much error you have between decoded and input data by watching the terminal stdout error metrics. 

```
./synthesis train data.tsv --out_enc model.encoder --out_dec model.decoder  -e Labels
```
--out_dec -> name/location you want the decoder to be saved as

--out_enc -> name/location you want the encoder to be saved as

-e Exclude the label column from the training data In this case it is called "Labels"

## Run the below command to generate new synthetic data from trained models

```
./synthesis gen labels.tsv --encoder model.encoder --decoder model.decoder --out gen.tsv
```

--decoder -> the name of the decoder.

--encoder -> the name of the encoder.

--out -> the name of the output file that the synth data will be generated in

## Run the below command to get decoded data from the models/input tsv

```
./synthesis gen_decoded data/BRCA.tsv --encoder model.encoder --decoder model.decoder
```
provide an encoder and decoder Keras style model file with a datafile. Should be in the 
same format as the datafile that is created when the xena dataset is preprocessed

## Run the below command to get a UMAP of two Files
These files could be synth generations/decoded samples/ raw data.

They just have to be in the format that is consistantly used throughout this tool.

```
./synthesis gen_UMAP -f1 DECODED.tsv -f2 data/BRCA.tsv --label-col Labels
```
NOTE: Label col header name must be the same name on both files or this script will not work.





