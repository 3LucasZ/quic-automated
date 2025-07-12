# Mac Installation Guide
- pip install: numpy, matplotlib, ruptures
- brew install --cask wirshark
- brew install proxygen
    - /opt/homebrew/Cellar/proxygen/2025.06.30.00
    - PROXYGEN_EXEC_PATH = '/opt/homebrew/Cellar/proxygen/2025.06.30.00/bin/hq'
- DO NOT install wolfSSL (Linux only)! OpenSSL which is somehow already installed on my mac is good enough!
- install libnghttp3 as described via git, NOT homebrew
- git clone --recursive https://github.com/ngtcp2/ngtcp2
    - cd ngtcp2
    - autoreconf -i
    - Use this command: ```./configure PKG_CONFIG_PATH=/Users/lucaszheng/Documents/GitHub/quic-automated/nghttp3/build/lib/pkgconfig LIBEV_CFLAGS="-I/opt/homebrew/Cellar/libev/4.33/include" LIBEV_LIBS="-L/opt/homebrew/Cellar/libev/4.33/lib -lev"```
    - make -j$(nproc) check
    - find . -type f -perm +111 2>/dev/null | grep ssl   # find executables *ssl*

# Usage Guide
- python main.py