echo $https_proxy 
echo $http_proxy 
echo $no_proxy 

WORKDIR="/home/vagrant"

echo "root dependencies"
sudo apk update && sudo apt-get install -y curl,wget 

# echo "docker"
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# echo \
#   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# sudo apt-get update && sudo apt-get install docker-ce 
# sudo usermod -aG docker $USER && newgrp docker

echo "minikube"
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo dpkg -i minikube_latest_amd64.deb

echo "installing kubectl"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

echo "getting che"
sudo apk install git 
wget -v https://github.com/che-incubator/chectl/releases/download/7.28.1/chectl-linux-x64.tar.gz
tar -xvf chectl-linux-x64.tar.gz && rm -rf chectl-linux-x64.tar.gz
cd chectl/bin

echo "starting minikube with docker driver running inside dind"

sudo swapoff -a

export MINIKUBE_IN_STYLE=false
PRIVATE_NETWORK_IP=$(ifconfig eth1 | grep "inet " | cut -d' ' -f 10)
sudo -E minikube start -v 4 --vm-driver none --kubernetes-version v${KUBERNETES_VERSION} --bootstrapper kubeadm \
    --extra-config kubelet.node-ip=$PRIVATE_NETWORK_IP \
    2>/dev/null

sudo -E minikube addons  enable ingress

# configuring minikube config proxies commands 
    printf "export MINIKUBE_WANTUPDATENOTIFICATION=false\n" >> /home/vagrant/.bashrc
    printf "export MINIKUBE_WANTREPORTERRORPROMPT=false\n" >> /home/vagrant/.bashrc
    printf "export MINIKUBE_HOME=/home/vagrant\n" >> /home/vagrant/.bashrc
    printf "export CHANGE_MINIKUBE_NONE_USER=true\n" >> /home/vagrant/.bashrc
    printf "export KUBECONFIG=/home/vagrant/.kube/config\n" >> /home/vagrant/.bashrc
    printf "source <(kubectl completion bash)\n" >> /home/vagrant/.bashrc

sudo chown -R $USER:$USER $HOME/.kube
sudo chown -R $USER:$USER $HOME/.minikube

sudo sysctl -w vm.max_map_count=262144
sudo echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.d/90-vm_max_map_count.conf

kubectl wait --timeout=300s --for=condition=Ready -n kube-system pod -l k8s-app=kube-proxy
sleep 120
kubectl wait --timeout=300s --for=condition=Ready -n kube-system pod -l component=etcd

echo "Waiting for coredns..."
kubectl wait --timeout=300s --for=condition=Ready -n kube-system pod -l k8s-app=kube-dns

echo "Waiting for ingress..."
kubectl wait --timeout=300s --for=condition=Ready -n kube-system pod -l app.kubernetes.io/component=controller,app.kubernetes.io/name=ingress-nginx

echo "installing and getting che"
echo $pwd 

sudo apt-get install wget 
apt-get 

