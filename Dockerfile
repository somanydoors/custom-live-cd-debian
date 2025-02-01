FROM debian:12

# Install live-build
RUN apt-get update \
	&& apt-get install -y \
		live-build \
	&& rm -rf /var/lib/apt/lists/*

# Create a directory for live cd config and build
WORKDIR /livecd
