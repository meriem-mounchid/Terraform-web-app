### Install GIT ###
ssh-keygen -t ed25519 -C meriemmounchid1@gmail.com
cat ~/.ssh/id_ed25519.pub
sudo apt install git

git config --global user.email meriemmounchid1@gmail.com
git config --global user.name meriem-mounchid

### Permission ###
sudo usermod -aG sudo misaki
sudo usermod -aG docker misaki
newgrp docker

### Install Docker ###
sudo apt-get install docker.io

### Install Terraform ###
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
# Install the HashiCorp GPG key.
wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update
sudo apt-get install terraform
# TEST:     terraform -help
# INIT:     terraform init
# APPLY:    terraform apply
# RUN:      localhost:8000
# STOP:     terraform destroy