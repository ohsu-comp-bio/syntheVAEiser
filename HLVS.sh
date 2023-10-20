#!/bin/bash
#SBATCH --partition gpu --gres gpu:1
#SBATCH --job-name=synth_gen_pan_TCGA
#SBATCH --time=0-2:00:00
#SBATCH --output=./output_reports/slurm.%N.%j.out
#SBATCH --error=./error_reports/slurm.%N.%j.err
#SBATCH --mail-type=END,FAIL,START
#SBATCH --mail-user=<user>@<org>.edu

# pass cancer cohort index on command line:
# sbatch HLVS.sh n
# where n = 0 to 24, for each cancer

source project_root/bin/activate
python HLVS.py 'output_dir_name/' '/train_file_path/*.tsv' $1 40 10 150