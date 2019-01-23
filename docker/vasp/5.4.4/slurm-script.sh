#!/bin/bash -l
#SBATCH --job-name=vasp5.4-docker
#SBATCH --partition=gorn
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --output=vasp.o%j
#SBATCH --error=vasp.e%j
 
### ENVIRONMENT ###
SWAP_DIR=/scratch/$USER/$SLURM_JOB_ID
if [ ! -d "$SWAP_DIR" ]; then
   mkdir -p $SWAP_DIR || exit $?
   cp -r $SLURM_SUBMIT_DIR/* $SWAP_DIR || exit $?
fi
chmod 777 $SWAP_DIR && cd $SWAP_DIR

### MODULES ###
docker load < /data/ubuntu18.04.tar
docker load < /data/vasp5.4.4.tar 

### VARS ###
VERSION="gam" # std for starndard, gam for famma-only or ncl for non-collinear version

### EXECUTION ###
docker run -v $PWD:/scratch -c 2 -e NPROCS=2 -e VERSION=$VERSION --rm vasp:5.4.4 &> dockerrun.log

### RESULTS ###
cp -rp $SWAP_DIR $SLURM_SUBMIT_DIR/$SLURM_JOB_ID
