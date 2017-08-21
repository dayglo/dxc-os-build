DXC OS build example
====================

This project builds vm templates and uploads them to the management infrastructure. Currently only ubuntu on vmware is supported.

To use this project, you will need to install:-

1. [packer](https://www.packer.io/downloads.html); 
1. [vsphere packer builder](https://github.com/dayglo/packer-builder-vsphere);
1. vmware [workstation](https://www.vmware.com/products/workstation/workstation-evaluation.html) or [fusion](https://www.vmware.com/products/fusion/fusion-evaluation.html) (dxc users can get this from the IT tool); 
1. [ovftool](https://www.vmware.com/support/developer/ovf/); 
1. [govc](https://github.com/vmware/govmomi/releases);
1. [jq](https://stedolan.github.io/jq/download/) 

You also need access to the internet (currently).

1. Clone the repo,
1. Copy variables.json.example to variables.json
1. Add your vcenter details to variables.json
1. run build-ubuntu.sh (tested on mingw);
1. run build-kubernetes.sh

TODO: deploy customisation templates automatically.

