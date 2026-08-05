
Build steps (Linux, some commands have to be adapted for Windows):

**Install docker:**

    sudo apt update
    sudo apt install docker.io

    sudo systemctl enable docker
    sudo systemctl start docker

**Clone from github:**

    cd ~
    mkdir vesc
    cd vesc
    git clone git@github.com:Mraz-Robotics/vesc-fw.git vesc-fw
    cd vesc-fw

**Check current branch:**

    git branch -a 

**Use whichever branch you like (depending on VESC Tool version):**

    git checkout release_6_02

**Build docker image:**

    sudo docker build -t vesc-builder .

**Run it:**

    sudo docker run -it --rm \
        -v ~/vesc/vesc-fw:/bldc \
        -w /bldc \
        vesc-builder
    
    
**Build .bin for target board:**

    make arm_sdk_install

The build output can be found in the `build` folder.
