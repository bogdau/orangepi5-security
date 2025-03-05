FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV YOCTO_DIR=/home/yocto/yocto
ENV YOCTO_BUILD_DIR=$YOCTO_DIR/build

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    diffstat \
    gawk \
    git \
    python3 \
    python3-pip \
    python3-pexpect \
    socat \
    cpio \
    chrpath \
    wget \
    file \
    locales \
    sudo \
    vim \
    tmux \
    curl \
    nano \
    xz-utils \
    iputils-ping \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set locale
RUN locale-gen en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Create a user to avoid building as root
RUN useradd -m -s /bin/bash yocto && \
    echo 'yocto ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# Switch to Yocto user
USER yocto
WORKDIR /home/yocto

# Clone Yocto sources
RUN git clone -b scarthgap git://git.yoctoproject.org/poky.git $YOCTO_DIR && \
    cd $YOCTO_DIR && \
    git clone -b scarthgap git://git.yoctoproject.org/meta-rockchip && \
    git clone -b scarthgap git://git.openembedded.org/meta-openembedded && \
    git clone -b scarthgap git://git.yoctoproject.org/meta-virtualization && \
    git clone -b scarthgap git://git.openembedded.org/openembedded-core

# Entry point
CMD ["/bin/bash"]