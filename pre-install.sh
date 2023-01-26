### Install GIT ###
ssh-keygen -t ed25519 -C meriemmounchid1@gmail.com
cat ~/.ssh/id_ed25519.pub
sudo apt install git

git config --global user.email meriemmounchid1@gmail.com
git config --global user.name meriem-mounchid

### Install Tools ###
sudo apt install -y curl vim unzip
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
# FMT:      terraform fmt (Terraform will print out the names of the files it modified)
# Validate: terraform validate

###  Install AWS CLI ###
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
#Test: /usr/local/bin/aws --version 

### EXPORT ###
export AWS_ACCESS_KEY_ID=AKIAWKDZT2H3GK63HK7J
export AWS_SECRET_ACCESS_KEY=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


### Create a default subnet ###
aws ec2 create-default-subnet --availability-zone eu-west-1a
# SubnetId: subnet-0aba2566aa6f9da42
# VpcId: vpc-0a163ed0bdd23126e

  #lifecycle {
    # When attaching VPN gateways it is common to define aws_vpn_gateway_route_propagation
    # resources that manipulate the attributes of the routing table (typically for the private subnets)
    #ignore_changes = [propagating_vgws]
  #}
  #tags = merge(local.common_tags, tomap({
  #  Name        = join("-", [local.prefix, "public-route-table"]),
  #  description = "public route used for api/web: public instances require public accessibility"
  #}))

    #tags = merge(local.common_tags, tomap({ Name = join("-", [local.prefix, "igw"]) }))
