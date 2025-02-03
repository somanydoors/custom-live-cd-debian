#!/bin/sh

set -euo pipefail

BOOT_IMAGE_WIDTH=${BOOT_IMAGE_WIDTH:-}
BOOT_IMAGE_HEIGHT=${BOOT_IMAGE_HEIGHT:-}
BOOT_IMAGE_Y_POS=${BOOT_IMAGE_Y_POS:-}
BOOT_IMAGE_X_POS=${BOOT_IMAGE_X_POS:-}
BOOT_IMAGE_BASE64=${BOOT_IMAGE_BASE64:-}
BOOT_IMAGE_TITLE=${BOOT_IMAGE_TITLE:-}
SPLASH_IMAGE=${SPLASH_IMAGE:-config/bootloaders/syslinux_common/splash.svg}

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
chown root:root config/includes.chroot/etc/motd
chmod 644 config/includes.chroot/etc/motd

if [ -n "${GITHUB_USERNAME}"]; then
    echo "curl -o /root/.ssh/authorized_keys https://github.com/${GITHUB_USERNAME}.keys" > config/includes.chroot/lib/live/config/9001-install-public-keys-from-github
    chown root:root config/includes.chroot/lib/live/config/9001-install-public-keys-from-github
    chmod u=rwx,go=rx config/includes.chroot/lib/live/config/9001-install-public-keys-from-github
fi

if [[ -z "${BOOT_IMAGE_WIDTH}" ]] \
	|| [[ -z "${BOOT_IMAGE_HEIGHT}" ]] \
	|| [[ -z "${BOOT_IMAGE_Y_POS}" ]] \
	|| [[ -z "${BOOT_IMAGE_X_POS}" ]] \
	|| [[ -z "${BOOT_IMAGE_BASE64}" ]] \
	|| [[ -z "${BOOT_IMAGE_TITLE}" ]] \
	|| [[ -z "${SPLASH_IMAGE}" ]]; then
	echo "[WARNING] Required configuration for custom boot image was not met"
	echo -e "If you want to customize the boot image,\nplease ensure the following are set:\n- BOOT_IMAGE_WIDTH\n- BOOT_IMAGE_HEIGHT\n- BOOT_IMAGE_Y_POS\n- BOOT_IMAGE_X_POS\n- BOOT_IMAGE_BASE64\n- BOOT_IMAGE_TITLE\n- SPLASH_IMAGE"
else
    BOOT_IMAGE_PLACEHOLDER='<!-- BOOT IMAGE PLACEHOLDER -->'
    BOOT_IMAGE_SVG_INJECT="<image width='${BOOT_IMAGE_WIDTH}' height='${BOOT_IMAGE_HEIGHT}' y='${BOOT_IMAGE_Y_POS}' x='${BOOT_IMAGE_X_POS}' xlink:href='data:image/png;base64,${BOOT_IMAGE_BASE64}'><title>${BOOT_IMAGE_TITLE}</title></image>"
    sed "s~${BOOT_IMAGE_PLACEHOLDER}~${BOOT_IMAGE_SVG_INJECT}~" "${SPLASH_IMAGE}"
fi

lb build
mv live-image-amd64.hybrid.iso "$ISO_OUT_DIR/$ISO_OUT_NAME.iso"
