#!/bin/bash
set -e 
set -x

export MSYS_NO_PATHCONV=1
export GOVC_INSECURE=`	cat variables.json	| jq -r '.["vcenter-insecure"]'`
export GOVC_URL=`		cat variables.json	| jq -r '.["vcenter-host"]'`
export GOVC_USERNAME=`	cat variables.json	| jq -r '.["vcenter-username"]'`
export GOVC_PASSWORD=`	cat variables.json	| jq -r '.["vcenter-password"]'`
export GOVC_DATACENTER=`cat variables.json	| jq -r '.["vcenter-datacenter"]'`

# First time run, set up key
if [ ! -e $HOME/.ssh/dxckubespraydev ]; then
	ssh-keygen -N '' -f $HOME/.ssh/dxckubespraydev
fi

echo "echo $(cat $HOME/.ssh/dxckubespraydev.pub) >> ~/.ssh/authorized_keys" > lib/packer-templates/scripts/deploy-dxc-key.sh
chmod +x lib/packer-templates/scripts/deploy-dxc-key.sh

cp -fr nodes lib/packer-templates/http/

pushd lib/packer-templates
rm -rf output-dxc-centos-7.3-x86_64-vmware-iso.old
mv output-dxc-centos-7.3-x86_64-vmware-iso output-dxc-centos-7.3-x86_64-vmware-iso.old || true

sleep 1

govc vm.destroy DXC-CENTOS7.3-TEMPLATE || true

PACKER_LOG=1 packer build --only=vmware-iso --var-file ../../variables.json ../../dxc-centos-7.3-x86_64.json

govc vm.markastemplate DXC-CENTOS7.3-TEMPLATE

rm -f scripts/deploy-dxc-key.sh
rm -rf http/nodes

popd