FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    git \
    wget \
    make \
    build-essential \
    libgl-dev \
    libxcb-xinerama0 \
    python3 \
    python3-pip \
    openocd

WORKDIR /bldc

CMD ["/bin/bash"]



#FROM ubuntu:22.04
#ENV DEBIAN_FRONTEND=noninteractive

#RUN apt update && apt install -y \
#    git wget make build-essential \
#    bzip2 xz-utils ca-certificates \
#    python3 python3-pip \
#    openocd \
# && rm -rf /var/lib/apt/lists/*

#WORKDIR /bldc
#CMD ["/bin/bash"]


#FROM ubuntu:14.04

# User setup
#RUN apt-get update && apt-get install -y sudo

#ENV USR_DOCKER docker
#ENV HOME /home/$USR_DOCKER

#RUN adduser --disabled-password --gecos '' $USR_DOCKER
#RUN adduser $USR_DOCKER sudo

#RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> \
#/etc/sudoers

#USER $USR_DOCKER
#RUN sudo apt-get update

# Install ARM toolchain
#RUN sudo apt install -y software-properties-common && \
#	sudo add-apt-repository -y ppa:team-gcc-arm-embedded/ppa && \
#	sudo apt update
#RUN echo "Expect : ~5 min" && \
#	sudo apt install -y gcc-arm-embedded

# Install build essentials
#RUN echo "Expect : ~2 min" && \
#	sudo apt install -y build-essential && \
#	sudo rm /usr/bin/make

# Uninstall make above and replace wwith make v4+
#RUN sudo apt install wget 

#WORKDIR $HOME
#RUN sudo wget https://ftp.gnu.org/gnu/make/make-4.1.tar.gz --no-check-certificate
#RUN sudo tar xfz make-4.1.tar.gz

#WORKDIR $HOME/make-4.1
#RUN ./configure
#RUN ./build.sh
#RUN ./make --version
#RUN sudo ln -s ~/make-4.1/make /usr/bin/make

#WORKDIR $HOME

# Build with 
# 			docker build . -f .\Dockerfile -t vescfw_v5.2:latest
# Run with
# 			docker run -it -v <your local path>\bldc:/bldc -w /bldc vescfw_v5.2:latest /bin/bash
