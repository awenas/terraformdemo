 wget https://kubernetes.io/docs/user-guide/walkthrough/pod-nginx.yaml
 kubectl create -f pod-nginx.yaml 
 kubectl get nodes
 kubectl get pods
 kubectl run busybox --image=busybox --restart=Never --tty -i --generator=run-pod/v1 --env "POD_IP=$(kubectl get pod nginx -o go-template='{{.status.podIP}}')"
 wget -qO- http://$POD_IP

 kubectl exec -it nginx -- /bin/bash
 apt-get install net-tools
 apt-get install procps

