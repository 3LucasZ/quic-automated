FROM ubuntu:24.04
# Avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# --- Install Proxygen ---
RUN apt-get update && apt-get install -y git sudo lsb-release libfast-float-dev
WORKDIR /opt/
RUN git clone https://github.com/facebook/proxygen
WORKDIR /opt/proxygen/proxygen
RUN ./build.sh -j $(nproc)
RUN ./install.sh


# Update package lists and install dependencies
# - software-properties-common is needed for add-apt-repository
# - build-essential, git, cmake, autoconf, libtool are for compiling C/C++ projects
# - python3, python3-pip for Python
# - tshark command line tool
# - other dependencies are for proxygen and wolfSSL
# RUN apt-get update && \
#     apt-get install -y \
#     software-properties-common \
#     build-essential \
#     git \
#     cmake \
#     autoconf \
#     automake \
#     libtool \
#     pkg-config \
#     wget \
#     unzip \
#     python3 \
#     python3-pip \
#     tshark \
#     libssl-dev \
#     libev-dev \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*
# # Install Python libraries
# RUN pip3 install --no-cache-dir numpy matplotlib ruptures


# # --- PART 2 ---

# WORKDIR /usr/src
# # Clone the proxygen repository
# RUN git clone https://github.com/facebook/proxygen.git && \
#     cd proxygen/proxygen && \
#     ./build.sh && \
#     # The build script handles installation
#     cd ../.. && \
#     rm -rf proxygen
# # --- Install wolfSSL, nghttp3, and ngtcp2 from source ---
# WORKDIR /usr/src
# RUN export BUILD_DIR=/usr/local && \
#     # --- Install wolfSSL v5.8.2-stable ---
#     git clone --depth 1 -b v5.8.2-stable https://github.com/wolfSSL/wolfssl && \
#     cd wolfssl && \
#     ./autogen.sh && \
#     ./configure --prefix=$BUILD_DIR \
#     --enable-all --enable-aesni --enable-harden --enable-keylog-export \
#     --disable-ech --enable-mlkem && \
#     make -j$(nproc) && \
#     make install && \
#     cd .. && \
#     # --- Install nghttp3 ---
#     git clone --recursive https://github.com/ngtcp2/nghttp3 && \
#     cd nghttp3 && \
#     autoreconf -i && \
#     ./configure --prefix=$BUILD_DIR --enable-lib-only && \
#     make -j$(nproc) && \
#     make install && \
#     cd .. && \
#     # --- Install ngtcp2 ---
#     git clone --recursive https://github.com/ngtcp2/ngtcp2 && \
#     cd ngtcp2 && \
#     autoreconf -i && \
#     ./configure PKG_CONFIG_PATH=$BUILD_DIR/lib/pkgconfig \
#     --prefix=$BUILD_DIR \
#     --with-wolfssl && \
#     make -j$(nproc) check && \
#     make install && \
#     cd .. && \
#     # --- Clean up build files and update library cache ---
#     rm -rf wolfssl nghttp3 ngtcp2 && \
#     ldconfig

# # -- PART 3 --
# # --- Copy application files from your repository ---
# COPY . /app
# WORKDIR /app
# # Set the default command to bash
# CMD ["/bin/bash"]