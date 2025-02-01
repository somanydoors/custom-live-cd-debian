FROM debian:12

# Install live-build
RUN apt-get update \
	&& apt-get install -y \
		live-build \
	&& rm -rf /var/lib/apt/lists/*
