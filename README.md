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

## Run the below command to preprocess the dataset

```
./synthesis preprocess big_data.tsv.gz -t --label-file brca_pam50 --label-col PAM50
```

-t -> transpose the entire dataset so that samples are rows and columns are features

--label-file -> the name of the 

--label-col -> the name of the column that holds the labels to generate synthentic samples for

## Run the below command to train an encoder/decoder from formatted data

NOTE you will have to tune your dataset with optional hyperparamaters arguments 
to get the decoded data to be in the same ballpark as the data you use to train your models.
You can measure how much error you have between decoded and input data by watching the terminal stdout error metrics. 

```
./synthesis train data.tsv --out model  -e Labels
```
--out -> save each model with the "model" prefix, eg model.encoder and model.decoder by default arugments

-e Exclude the label column from the training data

## Run the below command to generate new synthetic data from trained models

```
./synthesis gen labels.tsv --encoder model --decoder model --out gen.tsv
```

--decoder -> the name of the decoder assumes it ends in .decoder

--encoder -> the name of the encoder assumes the fike ends in .encoder

--out -> the name of the output file that the synth data will be generated in

## Run the below command to get decoded data from the models/input tsv

```
./synthesis gen_decoded labels.tsv -o decoded.tsv
```




