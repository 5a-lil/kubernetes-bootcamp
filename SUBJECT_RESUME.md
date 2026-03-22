
### SHORTEN SUBJECT GLOBAL DIRECTIVES:

- K3d, K3s, K8s, Vagrant, Kubernetes
- Project done in virtual machine
- You have to put all the configuration files of your project in folders located at the root of your repository
- The folders of the mandatory part will be named: p1, p2 and p3, and the bonus
- one: bonus.
- You can use any tools you want to set up your host virtual machine as
- well as the provider used in Vagrant.
- This project will consist of setting up several environments under specific rules.
- Part 1: K3s and Vagrant
- Part 2: K3s and three simple applications
- Part 3: K3d and Argo CD
- Scripts in "scripts" folder
- Configuration files in "confs" folder
- The evaluation process will happen on the computer of the evaluated
- group.
---
### SHORTEN SUBJECT GLOBAL NOTIONS
- [ ] K3d ?
- [x] K3s ?
- [ ] "K3s and its Ingress" ?
- [x] Vagrant ?
- [x] "set up a personal virtual machine with Vagrant and the distribution of your choice" ?
- [ ] Kubernetes ?
- [x] K8s ?

echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib' >> /etc/apt/sources.list
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
sudo apt-get update
sudo apt-get install virtualbox-7.1
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vagrant
