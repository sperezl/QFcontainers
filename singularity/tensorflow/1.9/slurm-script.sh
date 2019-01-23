#!/bin/bash -l
#SBATCH --job-name=Tensorflow
#SBATCH --partition=gorn
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --gres=gpu:1

### MODULES ###
module load singularity/2.5

### EXECUTION ###
singularity exec --nv $SIMAGES/tensorflow-gpu.1.9.0.simg \
        python3 classification.py
