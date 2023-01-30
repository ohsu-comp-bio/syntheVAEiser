# synthesis




## Examples
Create generative model using BRCA dataset, but remove `Labels` column.

```
./synthesis train data/BRCA.tsv -e Labels
```

Create synthetic data using BRCA dataset 

```
./synthesis gen data/BRCA.tsv --num-sample-gen 250
```