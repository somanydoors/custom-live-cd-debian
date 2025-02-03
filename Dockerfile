FROM debian:12

ENV APT="aptitude"
ENV APT_INDICES=false
ENV APT_MIRROR="https://deb.debian.org/debian"
ENV APT_SECURITY_MIRROR="https://security.debian.org/debian-security"
ENV ARCHITECTURE="amd64"
ENV ARCHIVE_AREAS="main contrib non-free-firmware"
ENV BOOT_IMAGE_BASE64=""
ENV BOOT_IMAGE_HEIGHT=""
ENV BOOT_IMAGE_TITLE=""
ENV BOOT_IMAGE_WIDTH=""
ENV BOOT_IMAGE_X_POS=""
ENV BOOT_IMAGE_Y_POS=""
ENV BOOTAPPEND_LIVE="boot=live components quiet splash noeject"
ENV CHROOT_FILESYSTEM="squashfs"
ENV DISTRIBUTION="bookworm"
ENV ISO_OUT_DIR="/livecd/iso"
ENV ISO_OUT_NAME="live-image-amd64.hybrid"
ENV MEMTEST="none"
ENV MOTD="Welcome to the So Many Doors live CD!"
ENV SPLASH_IMAGE="config/bootloaders/syslinux_common/splash.svg"
ENV UEFI_SECURE_BOOT="enable"

# Install live-build
RUN apt-get update \
	&& apt-get install -y \
		live-build \
	&& rm -rf /var/lib/apt/lists/*

# Create a directory for live cd config and build
WORKDIR /livecd

# Copy in the list of packages to include in the live CD
COPY --chmod=644 package-lists/* config/package-lists/

# Copy in the bootloader menu config
COPY --chmod=644 bootloaders config/bootloaders/

# Copy in CMD script
COPY --chmod=755 --chown=root:root files/start.sh /

# Build the image
CMD ["/start.sh"]
