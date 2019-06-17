#!/bin/bash -l
#SBATCH --job-name=cp2k
#SBATCH --partition=gorn
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --output=cp2k-sing.o%j
#SBATCH --error=cp2k-sing.e%j
 
### ENVIRONMENT ###
cd ${SLURM_SUBMIT_DIR} 

### MODULES ###
module load singularity/3.2.1
 
### EXECUTION ###
singularity exec $SIMAGES/cp2k-5.1.simg \
    mpirun -np 8 cp2k.popt -i test.inp -o output.out
