# Ubuntu 17.04 with Cp2k4.1
FROM ubuntu:17.04
# Metadata 
LABEL   maintainer="sergi.perez@uab.cat" \
        program.name="cp2k" \
        program.version="4.1" \
        program.release-date="2017-06-27"

# 
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
