# Proxmox_IP_Migrator

An autonomous Bash automation tool designed for Proxmox VE (PVE) hosts running on dynamic residential DHCP networks. This script monitors host network alterations (such as changing internet service providers or routers) and dynamically enumerates the updated IP configurations of all underlying Linux Containers (LXC) and Virtual Machines (QEMU).

## Theme Overview
This tool is designed to complement my homelab theme of a Star Wars Imperial Fleet. My goal is that whenever the IP on my server changes, I will recieve an email notification from the Fleet Admiral detailing its new IP Address as a new location in the galaxy.

## Features
* **Stateful Monitoring:** Tracks the host's IPv4 network state using a local caching mechanism to prevent redundant execution.
* **Proxmox CLI Integration:** Leverages native `pct` and `qm` commands to cleanly iterate through infrastructure clusters.
* **High-Precision Targeting:** Utilizes the QEMU Guest Agent inside VMs to fetch guaranteed, internally verified guest IP leases.
* **Automated Mail Alerts:** Automatically formats a structural system report and dispatches an email update via an authenticated secure SMTP relay.

## Architecture Overview
1. **Trigger:** Executed periodically via a system `cron` utility.
2. **Evaluation:** Captures the current active interface IP and cross-references it with a persistent local state file (`/var/local/pve_last_ip.txt`).
3. **Execution Layer:** If a subnet migration is identified, the script queries container network structures and triggers JSON-payload parsing via the QEMU Guest Agent for operational VMs.
4. **Notification:** A cleanly tabbed plain-text matrix parsing `[Asset/ID Name] --> [New DHCP IP]` is piped into an authenticated `msmtp` service configuration securely routed through Gmail SMTP.

## Requirements & Dependencies
* Proxmox VE 7.x / 8.x / 9.x
* QEMU Guest Agent (`qemu-guest-agent`) active on target Virtual Machines.
* Local system mail forwarder (`msmtp` or `ssmtp`) integrated with a secure App Password on a target Google/Gmail account.

## Modules Overview
This tool is divided into modules for ease of troubleshooting and customization. Each module is self-contained for the moment. Once all modules are refined and working correctly, a Master Script will be added that can oversee the entire process and call all the different functions. 
* **First Module:** `coordinate_gen.sh` This script is designed to randomly generate classic Star Wars galactic regions along with random sector grids. This will be tied to the notification and JSON modules to generate emails.
* **Second Module:** `ip_tracker.sh` This script is designed to read and capture the Proxmox host IP address and store it in a file for reference. If the host IP address changes, the script will echo the new IP address to overwrite the address on the file and then echo a notification of status change.
