# Proxmox_IP_Migrator

An autonomous Bash automation tool designed for Proxmox VE (PVE) hosts running on dynamic residential DHCP networks. This script monitors host network alterations (such as changing internet service providers or routers) and dynamically enumerates the updated IP configurations of all underlying Linux Containers (LXC) and Virtual Machines (QEMU).

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
