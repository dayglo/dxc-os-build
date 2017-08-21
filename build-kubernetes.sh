#!/bin/bash


set -e 
set -x

export GOVC_INSECURE=`cat variables.json 	| jq -r '.["vcenter-insecure"]'`
export GOVC_URL=`cat variables.json 		| jq -r '.["vcenter-host"]'`
export GOVC_USERNAME=`cat variables.json 	| jq -r '.["vcenter-username"]'`
export GOVC_PASSWORD=`cat variables.json 	| jq -r '.["vcenter-password"]'`
export GOVC_DATACENTER=`cat variables.json 	| jq -r '.["vcenter-datacenter"]'`

govc vm.destroy DXC-UBUNTU16.04-KUBERNETES || true

PACKER_LOG=1 packer build --var-file variables.json kubernetes-vcenter.json
