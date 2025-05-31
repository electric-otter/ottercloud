# Start from the latest Ubuntu LTS image
FROM ubuntu:22.04

# Set environment variables to make installs non-interactive
ENV DEBIAN_FRONTEND=noninteractive

# Update and install essential packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg \
    software-properties-common \
    sudo \
    systemd \
    && rm -rf /var/lib/apt/lists/*

# Optional: Add a non-root user called "otter"
RUN useradd -ms /bin/bash otter && adduser otter sudo
USER otter
WORKDIR /home/otter

# Copy your service files into the container
# (Assuming you have a local folder called "ottercloud")
COPY --chown=otter:otter ./ottercloud /home/otter/ottercloud

# Set the working directory
WORKDIR /home/otter/ottercloud

# Optional: Run setup scripts, install dependencies
# For example, if you use a language like Python, Node.js, or Go:
# RUN pip install -r requirements.txt
# RUN npm install

# Expose the port your service uses
EXPOSE 8080

CMD ["bash"]
