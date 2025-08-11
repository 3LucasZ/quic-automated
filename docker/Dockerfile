FROM ubuntu:24.04
# Avoid prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# install vcpkg
RUN apt-get update 
RUN apt-get install -y git sudo lsb-release
RUN git clone https://github.com/Microsoft/vcpkg.git /vcpkg
WORKDIR /vcpkg
RUN apt-get install -y curl zip unzip pkg-config build-essential
RUN ./bootstrap-vcpkg.sh
RUN ./vcpkg integrate install

# install proxygen
RUN apt-get install -y autoconf ca-certificates
RUN update-ca-certificates
RUN apt-get install -y automake libtool
RUN apt-get install -y python3 python3-pip
RUN ./vcpkg install proxygen

# -- install ngtcp --
# dependencies
RUN apt-get update && \
    apt-get install -y \
    git \
    build-essential \
    autoconf \
    automake \
    autotools-dev \
    libtool \
    pkg-config \
    libev-dev \
    libhttp-parser-dev \
    gcc-13 \
    g++-13

# Set the working directory
WORKDIR /usr/src

# Clone, build, and install wolfssl
RUN git clone --depth 1 -b v5.7.2-stable https://github.com/wolfSSL/wolfssl.git && \
    cd wolfssl && \
    ./autogen.sh && \
    ./configure --prefix=/usr/local --enable-all  --enable-harden --enable-keylog-export --disable-ech && \
    make -j$(nproc) && \
    make install

# Clone, build, and install nghttp3
RUN git clone --recursive https://github.com/ngtcp2/nghttp3.git && \
    cd nghttp3 && \
    autoreconf -i && \
    ./configure --prefix=/usr/local --enable-lib-only && \
    make -j$(nproc) check && \
    make install

# Clone, build, and install ngtcp2
RUN git clone --recursive https://github.com/ngtcp2/ngtcp2.git && \
    cd ngtcp2 && \
    autoreconf -i && \
    PKG_CONFIG_PATH=/usr/local/lib/pkgconfig ./configure --with-wolfssl && \
    make -j$(nproc) check && \
    make install


# ----- Application
RUN apt-get install -y python3-venv
RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
RUN pip install --no-cache-dir numpy matplotlib ruptures 
RUN pip install python-dotenv
RUN apt-get install -y tshark
# Create a directory for the application files
WORKDIR /app
# Copy project's files and run
COPY . .
COPY docker/param.json .
# Run automatically when container starts
CMD ["python", "main.py"]