#! /bin/bash

# =============================================================
# MODULE: ip_tracker.sh
# PURPOSE: Detects if the Proxmox host IP address has changed
# =============================================================
# Make executable via command " chmod +x ip_tracker.sh"

# 1. Define the tracking file path
STATE_FILE="/tmp/pve_last_ip.txt";

# 2. Capture the current active IP address using the awk command
# NOTE: To capture the Proxmox host IP (gateway) from inside a Linux container use command: CURRENT_IP=$(ip route show default | awk '{print $3}')
CURRENT_IP=$(ip route get 1.1.1.1 | awk '{print $7}') 

# 3. Read the previous IP from the state file (if file exists)
if [ -f "$STATE_FILE" ]; then
    PREVIOUS_IP=$(cat "$STATE_FILE")
else
    PREVIOUS_IP="FIRST_RUN"
fi

# 4. Compares the IP addresses
if [ "$CURRENT_IP" == "$PREVIOUS_IP" ]; then
    echo "STATUS: Fleet position stable. Current IP: $CURRENT_IP"
    exit 0
else
    echo "$CURRENT_IP" > "$STATE_FILE"
    echo "STATUS: Subnet change detected!"
    echo "OLD_IP: $PREVIOUS_IP"
    echo "NEW_IP: $CURRENT_IP"
fi

