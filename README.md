# Custom Debian Live CD Generator

Docker image to generate customized Debian live CD ISOs

***This project is in a late alpha - the core functionality works and is stable but a lot of work needs to be done on the UX.***

## Usage

### Configure the live CD

| Environment Variable | `lb` CLI Argument | Default Value | Details |
| -------------------- | ------------ | ------------- | ------- |
| `APT` | `--aptitude` | `apt` | Controls which package manager to use in the live CD environment |
| `APT_INDICIES` | `--apt-indices` | `false` | Controls whether the APT index lists are included in the live ISO |
| `APT_MIRROR` | `--mirror-binary`, `--mirror-bootstrap` | `https://deb.debian.org/debian` | Controls which APT mirror packages will be pulled from |
| `APT_SECURITY_MIRROR` | `--mirror-binary-security`, `--mirror-chroot-security` | `https://security.debian.org/debian-security` | Controls which APT mirror security updates will be pulled from |
| `ARCHITECTURE` | `--architecture` | `amd64` | Controls which architecture the live CD is built for |
| `ARCHIVE_AREAS` | `--archive-areas` | `main contrib non-free-firmware` | Controls which areas of the APT repositories are searched for packages |
| `BOOTAPPEND_LIVE` | `--bootappend-live` | `boot=live components quiet splash noeject` | Space-separated list of kernel parameters to append to the default kernel command line for the live CD |
| `CHROOT_FILESYSTEM` | `--chroot-filesystem` | `squashfs` | Controls the filesystem for storing the live OS root filesystem on the ISO |
| `DISTRIBUTION` | `--distribution` | `bookworm` | Controls which version of Debian is installed in the live OS |
| `ISO_OUT_DIR` | *N/A* | `/livecd/iso` | Controls the path where the built ISO should be placed inside the container |
| `ISO_OUT_NAME` | *N/A* | `live-image-amd64.hybrid` | Controls the base name (without ISO extension) of the output ISO image |
| `MEMTEST` | `--memtest` | `none` | Controls which, if any, `memtest` binary is included as a boot option on the live CD boot menu |
| `UEFI_SECURE_BOOT` | `--uefi-secure-boot` | `enable` | Controls whether the signed EFI binaries should be included in the live CD to support Secure Boot |
