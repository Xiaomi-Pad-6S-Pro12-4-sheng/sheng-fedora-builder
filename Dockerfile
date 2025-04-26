FROM fedora:42

RUN dnf update -y && dnf install -y bash arch-install-scripts bubblewrap systemd-container zip python3-pip dosfstools e2fsprogs rsync which mkosi

# Install qemu-user-static for other architectures
RUN uname -m | grep aarch64 || dnf install -y qemu-user-static-aarch64

WORKDIR /build/

COPY . .

CMD ["/bin/sh", "./docker-entry.sh"]
