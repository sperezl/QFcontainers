#!/bin/bash -l
#SBATCH --job-name=cp2k-docker
#SBATCH --partition=gorn
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --output=cp2k-docker.o%j
#SBATCH --error=cp2k-docker.e%j
 
### ENVIRONMENT ###
SWAP_DIR=/scratch/$USER/$SLURM_JOB_ID
if [ ! -d "$SWAP_DIR" ]; then
   mkdir -p $SWAP_DIR || exit $?
   cp -r $SLURM_SUBMIT_DIR/* $SWAP_DIR || exit $?
fi
chmod 777 /tmp/$USER/$SLURM_JOB_ID
cd $SWAP_DIR

### MODULES ###
docker load < /data/Docker-ubuntu.tar
docker load < /data/Docker-cp2k.tar 
 
### EXECUTION ###
docker run -v $PWD:/tmp -c 8 -e NPROCS=8 -e INPUT=input.inp -e OUTPUT=output.out --rm cp2k &> dockerrun.log

### RESULTS ###
chmod 750 /tmp/$USER/$SLURM_JOB_ID
cp -rp $SWAP_DIR $SLURM_SUBMIT_DIR/$SLURM_JOB_ID
