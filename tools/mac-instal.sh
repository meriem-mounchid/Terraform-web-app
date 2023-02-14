### Install Terraform on Mac ###
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
brew update
brew upgrade hashicorp/tap/terraform

### Install Brew ###
brew update --auto-update

### Install Docker on Mac ###
brew install docker --cask
# systemctl start docker
# sudo /etc/init.d/docker start
open /Applications/Docker.app