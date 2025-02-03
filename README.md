# Custom Debian Live CD Generator

Docker image to generate customized Debian live CD ISOs

***This project is in a late alpha - the core functionality works and is stable but a lot of work needs to be done on the UX.***

## Usage

```bash
docker run -it \
    -v "$(pwd)":/livecd/iso \
    ghcr.io/somanydoors/custom-live-cd-debian:12
```

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
| `GITHUB_USERNAME` | *N/A* | *Blank* | If set to a GitHub username, the public keys for that account will be installed into the live CD `root` account at boot |
| `ISO_OUT_DIR` | *N/A* | `/livecd/iso` | Controls the path where the built ISO should be placed inside the container |
| `ISO_OUT_NAME` | *N/A* | `live-image-amd64.hybrid` | Controls the base name (without ISO extension) of the output ISO image |
| `MEMTEST` | `--memtest` | `none` | Controls which, if any, `memtest` binary is included as a boot option on the live CD boot menu |
| `MOTD` | *N/A* | *Welcome to the So Many Doors live CD!* | |
| `UEFI_SECURE_BOOT` | `--uefi-secure-boot` | `enable` | Controls whether the signed EFI binaries should be included in the live CD to support Secure Boot |

### Customizing the Boot Image

You can set a custom boot image by setting the following values at runtime:

| Environment Variable | Description |
| -------------------- | ----------- |
| `BOOT_IMAGE_BASE64` | Base64 encoded PNG file |
| `BOOT_IMAGE_WIDTH` | Width (in pixels) of the PNG |
| `BOOT_IMAGE_HEIGHT` | Height (in pixels) of the PNG |
| `BOOT_IMAGE_X_POS` | Starting X position of the PNG |
| `BOOT_IMAGE_Y_POS` | Starting Y position of the PNG |
| `BOOT_IMAGE_TITLE` | Title of the image |

### Dynamic MOTD

If you put executable shell scripts into `update-motd.d` and rebuild the image, those scripts will be executed in alphabetical order after `/etc/motd` is printed to the console.


## References

- [Customizing Bootloader Settings](https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-binary.en.html)
- [Question with some reference syslinux.cfg](https://unix.stackexchange.com/questions/657474/debian-livebuild-how-to-make-the-bootloader-to-directly-boot-to-live)
- [Manpage for `lb config`](https://manpages.debian.org/unstable/live-build/lb_config.1.en.html)
- [Debian documentation on customizing live CD filesystem contents](https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-contents.en.html)
- [Debian documentation on live CD basics](https://live-team.pages.debian.net/live-manual/html/live-manual/the-basics.en.html)
- [Debian documentation on customizing the packages installed in the live CD](https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-package-installation.en.html)
- [Debian documentation on managing a live CD configuration (for live build servers, but good info)](https://live-team.pages.debian.net/live-manual/html/live-manual/managing-a-configuration.en.html)
- [Debian documentation overviewing the tools used in live CD creation](https://live-team.pages.debian.net/live-manual/html/live-manual/overview-of-tools.en.html)
- [Ubuntu documentation on the live build system](https://wiki.ubuntu.com/Live-Build)
- [Stackoverflow question about customizing syslinux boot menu timings](https://unix.stackexchange.com/questions/32243/how-do-i-configure-syslinux-to-boot-immediately)
- [Debian documentation on customizing the boot behaviour of the live CD environment](https://live-team.pages.debian.net/live-manual/html/live-manual/customizing-run-time-behaviours.en.html)
- [Debian live CD manual](https://live-team.pages.debian.net/live-manual/html/live-manual/index.en.html)
