# Ubuntu 18.04 with Cp2k 5.1-3 
FROM ubuntu:18.04
# Metadata
LABEL   maintainer="sergi.perez@uab.cat" \
        program.name="cp2k" \
        program.version="5.1-3" \
        program.release-date="2018-10-01"

# Installation
RUN apt-get update && apt-get install -y \
        # Dependencies 
        apt-utils \
        ssh \
        # Program 
        cp2k \
        cp2k-data 
        
# Environment  
WORKDIR /tmp
RUN useradd -s /bin/bash user
USER user

# Execution
CMD mpirun -np $NPROCS cp2k.popt -i /tmp/$INPUT -o /tmp/$OUTPUT
