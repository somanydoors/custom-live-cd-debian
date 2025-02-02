FROM debian:12

ENV APT="aptitude"
# Install live-build
RUN apt-get update \
	&& apt-get install -y \
		live-build \
	&& rm -rf /var/lib/apt/lists/*

# Create a directory for live cd config and build
WORKDIR /livecd

# Copy in the list of packages to include in the live CD
COPY --chmod=644 package-lists/* config/package-lists/

# Copy in CMD script
COPY --chmod=755 --chown=root:root files/start.sh /

# Build the image
CMD ["/start.sh"]
