# Mac Installation Guide
- pip install: numpy, matplotlib, ruptures
- brew install --cask wirshark
- brew install proxygen
    - /opt/homebrew/Cellar/proxygen/2025.06.30.00
    - PROXYGEN_EXEC_PATH = '/opt/homebrew/Cellar/proxygen/2025.06.30.00/bin/hq'
- brew install wolfssl
    - /opt/homebrew/Cellar/wolfssl/5.8.0
- brew install libnghttp3
    - https://github.com/ngtcp2/nghttp3
    - /opt/homebrew/Cellar/libnghttp3/1.10.1
- git clone --recursive https://github.com/ngtcp2/ngtcp2
    - cd ngtcp2
    - autoreconf -i
    - Use this command: ```./configure PKG_CONFIG_PATH=/opt/homebrew/Cellar/wolfssl/5.8.0/lib/pkgconfig:/opt/homebrew/Cellar/libnghttp3/1.10.1/lib/pkgconfig LIBEV_CFLAGS="-I/opt/homebrew/Cellar/libev/4.33/include" LIBEV_LIBS="-L/opt/homebrew/Cellar/libev/4.33/lib -lev" --with-wolfssl```
    - make -j$(nproc) check

# Usage Guide
- python main.py