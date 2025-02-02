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

if [ -z ${BOOT_IMAGE_BASE64} ]; then
BOOT_IMAGE_SVG_INJECT=$(cat <<EOF
    <image width="${BOOT_IMAGE_WIDTH}" height="${BOOT_IMAGE_HEIGHT}" y="${BOOT_IMAGE_Y_POS}" x="${BOOT_IMAGE_X_POS}" xlink:href="data:image/png;base64,${BOOT_IMAGE_BASE64}">
      <title>${BOOT_IMAGE_TITLE}</title>
    </image>
EOF
)

sed -i 's/<!-- BOOT IMAGE PLACEHOLDER -->/'"$BOOT_IMAGE_SVG_INJECT"'/g' "config/bootloaders/syslinux_common/splash.svg"
fi

lb build
mv live-image-amd64.hybrid.iso "$ISO_OUT_DIR/$ISO_OUT_NAME.iso"
