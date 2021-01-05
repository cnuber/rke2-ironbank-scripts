$script = <<-'SCRIPT'
cd /vagrant
# install rke2 flatten script pre-reqs

yumPackages=( https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm git jq wget docker-distribution )
for package in ${yumPackages[@]}; do
  sudo yum -y reinstall ${package} || sudo yum -y install ${package}
done

# enable the local docker registry

systemctl enable docker-distribution
systemctl start docker-distribution

# enable insecure local registry and restart docker

cat << EOF > /etc/docker/daemon.json
{
 "insecure-registries" : ["localhost:5000"]
}
EOF

systemctl restart docker

#create the RKE2 config and custom canal manifest

RKE2_CONFIG_DIRECTORY=/etc/rancher/rke2
IP_ADDRESS="$(ip address show dev eth1 scope global | awk '/inet / {split($2,var,"/"); print var[1]}')"
mkdir -p $RKE2_CONFIG_DIRECTORY
mkdir -p /var/lib/rancher/rke2/server/manifests

cat <<EOF > /var/lib/rancher/rke2/server/manifests/rke2-canal-config.yaml
apiVersion: helm.cattle.io/v1
kind: HelmChartConfig
metadata:
  name: rke2-canal
  namespace: kube-system
spec:
  valuesContent: |-
    iface: "eth1"
EOF

cat <<EOF > $RKE2_CONFIG_DIRECTORY/config.yaml
bind-address: $IP_ADDRESS
advertise-address: $IP_ADDRESS
system-default-registry: localhost:5000
tls-san:
 - $IP_ADDRESS
EOF

# run the image build script

SCRIPT

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision "docker"
  config.vm.provision "shell", inline: $script
  config.vm.network "public_network", bridge: ""
end
