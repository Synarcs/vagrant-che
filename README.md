# Vagrant Providers

## virtualbox-vagrant-provider (virtualbox) 
    * [x] ubuntu box 
    * [x] self configured proxies 
    * [x] install minikube,docker,kube-proxy 
    * [x] install eclipse che with share private network and folders

## docker-vagrant-provider 
    * [x] dind 
    * [x] minikube 
    * [x] custom made docker image 
    * [x] config cloud proxies 



## Installation 
    
    git clone  ""
    cd vagrant-che 
    vagrant up  (for virtualbox-provider)
    cd docker-provider && vagrant up  (for docker-provider) 


## Node 

    for changes in proxies and minikube change the installer,docker and minikube script as per requirement 
    
    Can also work with kind or HSA multi node kubernetes cluster

