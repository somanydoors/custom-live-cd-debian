#!/bin/sh

set -e

lb config \
    --apt "${APT}" \
    --apt-indices ${APT_INDICES} \
    --architecture "${ARCHITECTURE}" \
    --archive-areas "${ARCHIVE_AREAS}" \
    --bootappend-live "${BOOTAPPEND_LIVE}" \
    --chroot-filesystem "${CHROOT_FILESYSTEM}" \
    --distribution "${DISTRIBUTION}" \
    --memtest "${MEMTEST}" \
    --mirror-binary "${APT_MIRROR}" \
    --mirror-binary-security "${APT_SECURITY_MIRROR}" \
    --mirror-bootstrap "${APT_MIRROR}" \
    --mirror-chroot-security "${APT_SECURITY_MIRROR}" \
    --uefi-secure-boot "${UEFI_SECURE_BOOT}"

echo "${MOTD}" > config/includes.chroot/etc/motd
chmod 644 config/includes.chroot/etc/motd

if [ -n "${GITHUB_USERNAME}"]; then
    echo "curl -o /root/.ssh/authorized_keys https://github.com/${GITHUB_USERNAME}.keys" > config/includes.chroot/lib/live/config/9001-install-public-keys-from-github
    chown root:root config/includes.chroot/lib/live/config/9001-install-public-keys-from-github
    chmod u=rwx,go=rx config/includes.chroot/lib/live/config/9001-install-public-keys-from-github
fi

lb build
mv live-image-amd64.hybrid.iso "$ISO_OUT_DIR/$ISO_OUT_NAME.iso"
