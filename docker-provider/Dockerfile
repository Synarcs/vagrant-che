FROM alekslitvinenk/dind:latest 

ENV Kubectl_version=1.20.2
ENV docker_version=1.20.1 

WORKDIR /tmp/vagrant

RUN apk update 
RUN apk add  curl && apk add wget

RUN docker version | grep Version 

RUN  curl -q -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 2>/dev/null && \
    chmod +x minikube && \
    mv minikube /usr/local/bin/

RUN  curl -q -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBERNETES_VERSION}/bin/linux/amd64/kubectl 2>/dev/null && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

RUN echo "127.0.0.1 minikube minikube." | sudo tee -a /etc/hosts && \
    mkdir -p $HOME/.minikube && \
    mkdir -p $HOME/.kube && \
    touch $HOME/.kube/config

RUN export KUBECONFIG=$HOME/.kube/config
RUN chown -R $USER:$USER $HOME/.kube
RUN chown -R $USER:$USER $HOME/.minikube

RUN export MINIKUBE_IN_STYLE=false &&  \
    PRIVATE_NETWORK_IP=$(ifconfig eth1 | grep "inet " | cut -d' ' -f 10) && \
     -E minikube start -v 4 --vm-driver none --kubernetes-version v${KUBERNETES_VERSION} --bootstrapper kubeadm \
         --extra-config kubelet.node-ip=$PRIVATE_NETWORK_IP \
         2>/dev/null

CMD [ "./provider.sh" ]
