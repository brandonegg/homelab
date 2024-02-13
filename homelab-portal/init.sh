#!/bin/bash
sudo apt update

#################################
# Docker Installation (Rootless)
#################################
# uninstall any conflicting packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add & install apt sources
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Rootless configuration
sudo apt install -y newuidmap newgidmap dbus-user-sessio docker-ce-rootless-extras
dockerd-rootless-setuptool install

# Configure Systemd
systemctl --user start docker
systemctl --user enable docker
sudo loginctl enable-linger $(whoami)

#################################
# Start Services
#################################
docker compose up -d