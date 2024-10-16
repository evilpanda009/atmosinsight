#!/bin/bash

# Disable swap
echo "Disabling swap..."
sudo swapoff -a

# Edit sysctl config file to set vm.max_map_count
echo "Setting vm.max_map_count to 262144..."
if grep -q "^vm.max_map_count=" /etc/sysctl.conf; then
    sudo sed -i 's/^vm.max_map_count=.*/vm.max_map_count=262144/' /etc/sysctl.conf
else
    echo "vm.max_map_count=262144" | sudo tee -a /etc/sysctl.conf
fi

# Reload the kernel parameters
echo "Reloading kernel parameters..."
sudo sysctl -p

# Verify the change
echo "Verifying the change..."
cat /proc/sys/vm/max_map_count
