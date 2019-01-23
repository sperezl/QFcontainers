# Imatge Ubuntu 18.04 amb VASP 5.4.4 
# Imatge inicial
FROM ubuntu:18.04
#Info parells clau=valor 
LABEL   maintainer="sergi.perez@uab.cat" \
        program.name="vasp" \
        program.version="5.4.4" \
        program.release-date="2018-10-22"

RUN apt-get update && apt-get install -y \
        # Dependencies 
        make ssh rsync \
        build-essential gfortran \
	# Libs
	openmpi-common openmpi-bin libblacs-openmpi1 libopenmpi-dev \
	libscalapack-openmpi-dev libscalapack-openmpi2.0 \
	libblas3 libblas-dev \
	liblapack3 liblapack-dev \
	libtmglib3 libtmglib-dev \
	libfftw3-3 libfftw3-dev

# Install VASP
COPY vasp.5.4.4.tar.gz /tmp
RUN cd /tmp && tar xvf /tmp/vasp.5.4.4.tar.gz
RUN cp /tmp/vasp.5.4.4/arch/makefile.include.linux_gnu /tmp/vasp.5.4.4/makefile.include
RUN sed -i 's/LinuxGNU/DockerUbuntu/' /tmp/vasp.5.4.4/makefile.include
RUN sed -i 's/\/opt\/gfortran\/libs\//\/usr\/lib\/x86_64-linux-gnu/' /tmp/vasp.5.4.4/makefile.include
RUN sed -i 's/ -lrefblas/\/blas -lblas/' /tmp/vasp.5.4.4/makefile.include
RUN sed -i 's/ -lscalapack/ -lscalapack-openmpi/' /tmp/vasp.5.4.4/makefile.include
RUN sed -i 's/\/opt\/gfortran\/fftw-3.3.4-GCC-5.4.1/\/usr\/lib\/x86_64-linux-gnu/' /tmp/vasp.5.4.4/makefile.include
RUN sed -i 's/\/opt\/gfortran\/openmpi-1.10.2\/install\/ompi-1.10.2-GFORTRAN-5.4.1\/include/#/' /tmp/vasp.5.4.4/makefile.include
RUN sed -i 's/-I$(FFTW)/-I\/usr/' /tmp/vasp.5.4.4/makefile.include
RUN cd /tmp/vasp.5.4.4 && make all

# Environment
RUN useradd -ms /bin/bash user
USER user
WORKDIR /scratch

# Exec
CMD mpirun -np $NPROCS /tmp/vasp.5.4.4/bin/vasp_$VERSION 
