# FROM docker/whalesay:latest
# LABEL Name=arm2011 Version=0.0.1
# RUN apt-get -y update && apt-get install -y fortunes
# CMD ["sh", "-c", "/usr/games/fortune -a | cowsay"]

# FROM ubuntu:20.04
# LABEL Name=arm-9.2 Version=0.0.1

# RUN apt-get update
# RUN apt-get install -y --no-install-recommends \
#         make
# # Installing the necessary software
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         flex bison wget \
#         libncurses5-dev \ 
#         libncursesw5-dev \
#         lib32z1-dev \
#         lzop \
#         libssl-dev \
#         util-linux \
#         kpartx \
#         dosfstools \
#         e2fsprogs \
#         ca-certificates \
#         xz-utils \
#         make \
#         file \
#         gcc g++ patch cpio unzip rsync bc perl \
#         libglib2.0-dev \
#         git \
#         fakeroot \
#         curl \
#         python \
#         ssh \
#         gperf

# RUN apt-get autoremove -y; sudo apt-get clean; rm -rf /var/lib/apt/lists/*; rm /var/log/alternatives.log /var/log/apt/*; rm /var/log/* -r;

# # Cross-Compiler installation
# RUN wget -O /tmp/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz -c https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz
# RUN tar xf /tmp/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz -C /opt/
# RUN rm -rf /tmp/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf.tar.xz
# RUN mv /opt/gcc-arm-9.2-2019.12-x86_64-arm-none-linux-gnueabihf/ /opt/gcc-arm-linux

# # Now is necessary to modify the .bashrc located in our user directory to let the tool be permanently available.
# RUN cd ~ && \
#     echo "export PATH=$PATH:/opt/gcc-arm-linux/bin" >> .bashrc 

# RUN export FORCE_UNSAFE_CONFIGURE=1

# # After installing the compiler you can verify it using the following command
# #RUN arm-linux-gnueabihf-gcc --version

FROM ubuntu:latest

RUN dpkg --add-architecture i386 && apt-get update \
        && apt-get install -y --no-install-recommends \
                libxtst6:i386 \
                lib32stdc++6 \
                libxt6:i386 \
                libdbus-glib-1-2:i386 \
                libasound2:i386 \
                make \
                bzip2
RUN apt-get autoremove -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*rm /var/log/alternatives.log /var/log/apt/* \
        && rm /var/log/* -r

COPY arm-2011.09-70-arm-none-linux-gnueabi_stripped.tar.bz2 /tmp

RUN tar xjf /tmp/arm-2011.09-70-arm-none-linux-gnueabi_stripped.tar.bz2 -C /opt/ \
        && rm -rf /tmp/arm-2011.09-70-arm-none-linux-gnueabi_stripped.tar.bz2

ENV PATH="/opt/arm-2011.09/bin:${PATH}"
