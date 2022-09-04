---
tags:
  - kubernetes
---

## Prerequisite

1. CentOS 7

2. 配置好了静态IP

3. 网络连接

## Installation Script

为了避免每次想要在服务器上配置 Kubernetes 节点都要自己手动执行很多命令安装东西，我做了一个 Shell 脚本，这个只针对 CentOS。可以参考一下，也可以顺便学一学 Linux Shell。

如果有什么不懂的，可以参考这篇[文章](./kubernetes-on-centos.md)，这里只是加了一些逻辑来判断一些命令有没有必要执行。

```shell
#!/bin/sh

# Check if there is already kubeadm command here
# if kubeadm exists, there may be already installed Kubernetes
if command kubeadm &> /dev/null
then
  echo "[WARN] Kubernetes may be already installed. Please check again..."
  exit
fi

#
br_mod=$(lsmod | grep 'br_netfilter')

echo "Current mod for br_netfilter: $br_mod"

if [[ ! $br_mod =~ "br_netfilter" ]]; then
  echo "[WARN] There is no br_netfilter mod on this machine!"
  sudo modprobe br_netfilter
fi

echo "[INFO] br_netfilter mod loaded successfully!"
lsmod | grep br_netfilter

# 
sudo tee /etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

# Install docker if there is not docker installed
if ! command -v docker &> /dev/null
then
  # you can refer this article of Docker Installation: https://docs.docker.com/engine/install/centos/
  echo "[WARN] Docker is not installed, now we are going to install docker for Kubernetes!"
  # Remove docker first just in case
  sudo yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
  # Install yum-utils
  echo "[INFO] Install yum-utils..."
  sudo yum install -y yum-utils
  echo "[INFO] Add repo for docker-ce..."
  sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  echo "[INFO] Starting installing Docker..."
  sudo yum install -y docker-ce docker-ce-cli- containerd.io
  echo "[INFO] Docker installed successfully. Starting docker..."
  sudo systemctl start docker
  sudo systemctl enable docker
  echo "[INFO] Docker started..."
  sudo docker version
else
  echo "[INFO] Docker already exists...No need to install it."
  sudo systemctl start docker
  sudo docker version
fi

if ! command -v kubeadm &> /dev/null
then
  # There's no kubernetes components installed
  echo "[INFO] Add Kubernetes repository into local yum repositories..."
  cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF
  echo "[INFO] Kubernetes repo successfully added..."
else
  # Kubernetes related components may be already installed
  echo "[WARN] Kubernetes related application or components may be already installed."
  exit
fi

echo "[INFO] Start installing Kubernetes components: kubelet, kubeadm, kubectl"
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet

# After installing kubernetes, we have some steps to do
# Set SELinux in permissive mode (effectively disabling it)
echo "[INFO] Set SELinux in permissive mode..."
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

# Disable swap
echo "[INFO] Disable Swap..."
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a

# Enable necessary port
echo "[INFO] Start enable some necessary ports for Kubernetes..."
sudo firewall-cmd --add-port={6443,2379-2380,30000-32767,10250,10251,10252,5473,179,5473}/tcp --permanent
sudo firewall-cmd --add-port={4789,8285,8472}/udp --permanent
sudo firewall-cmd --reload

# append new domain name to hosts file
echo "[INFO] Start writing new domain name for kubernetes, please ensure your input is accurate and correct."
fileToAppend="/etc/hosts"
echo "If you input a wrong IP or Domain Name, please update it in $fileToAppend manually"
read -p "Please input ip address of your machine(e.g. 192.168.2.10): " ipAddr
read -p "Please input the domain name(e.g. 'k8s-master01 k8s-master01.torres.com'): " domainName
ipAddrDomain="$ipAddr $domainName"
echo "You are adding \"$ipAddrDomain\" as a new line into $fileToAppend."
echo $ipAddrDomain >> $fileToAppend

# Verify the installation, pull images from gcr.io
echo "[INFO] Start pulling relevant images about Kubernetes from gcr.io!"
sudo kubeadm config images pull

echo "Kubernetes installed successfully!!!!!!!!!!!!!!!"
```

<p style="color: red">Shell 脚本已经完成，你们可以测试一下这个脚本，如果有什么问题，尽管联系我。</p>
