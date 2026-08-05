| Section    | Purpose |
| -------- | ------- |
| suricata --version  | Confirms the binary is installed and callable. |
| systemctl status | Checks whether the service is running, activating, or failed. |
| tail suricata.log    | Retrieves the latest service events from systemd, which often contain the root cause of failures. | 
| ip -br addr | Lists the available network interfaces so you can compare them against the configuration. |
| grep "interface:" | Displays every interface configured in suricata.yaml, making it easy to spot incorrect values like eth0. |
| suricata -T | Verifies that the configuration and rules load successfully before starting the service. | 