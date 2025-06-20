FROM ubuntu:latest

ARG EMBEDDED_PKG=arm-2011.09-70-arm-none-linux-gnueabi_stripped.tar.bz2

COPY ${EMBEDDED_PKG} /tmp

# Pakage `tzdata` should be installed to make the enviroment vairable `TZ` work
# Setting the DEBIAN_FRONTEND environment variable suppresses the prompt that lets you select the correct timezone from a menu.
ENV TZ Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive

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
                tzdata \
                git \
                openssh-server \
        && apt-get autoremove -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*rm /var/log/alternatives.log /var/log/apt/* \
        && rm /var/log/* -r \
        && tar xjf /tmp/${EMBEDDED_PKG} -C /opt/ \
        && rm -rf /tmp/${EMBEDDED_PKG} \
        && mkdir -p /var/run/sshd

ENV PATH="/opt/arm-2011.09/bin:${PATH}"

# Set root password (for demonstration, change in production)
RUN echo 'root:root' | chpasswd

# Allow root login via SSH (for demonstration, change in production)
RUN sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH service by default
CMD ["/usr/sbin/sshd", "-D"]
