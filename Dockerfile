FROM ubuntu:latest

ARG EMBEDDED_PKG=arm-2011.09-70-arm-none-linux-gnueabi_stripped.tar.bz2

COPY ${EMBEDDED_PKG} /tmp

# The tool chain comes from https://sourcery.sw.siemens.com/GNUToolchain/kbentry62
# Following the instruction inside, we can get the tool chain working as expected.
# However, the pakages are mostly only needed for the setup UI so we can remove most of them, except lib32stdc++.
# lib32stdc++ is a must because if we do not install it, we will not be able to find the executable even we got the PATH right.
RUN dpkg --add-architecture i386 \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
                lib32stdc++6 \
                make \
                bzip2 \
        && apt-get autoremove -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*rm /var/log/alternatives.log /var/log/apt/* \
        && rm /var/log/* -r \
        && tar xjf /tmp/${EMBEDDED_PKG} -C /opt/ \
        && rm -rf /tmp/${EMBEDDED_PKG}

ENV PATH="/opt/arm-2011.09/bin:${PATH}"
