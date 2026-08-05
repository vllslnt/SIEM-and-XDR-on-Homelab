<a id="readme-top"></a>
<div align="center">
  <h1 align="center" style="text-decoration: none; border-bottom: none;">Network Analytics</h1>

  <p align="center">
    Using <span><strong>Suricata</strong></span>, an <span><strong>open source network analysis & threat detection software</strong></span>.
    <br />
    <br />
    <br />
  </p>
</div>

<!-- The Setup Process -->
## The Setup Process
### System Prepping
Making sure the server is healthy. Below are the steps taken to prepare the machine for a Suricata installation.<br>
A script has been provided within the folder named <kbd>"Suricata Integration"</kbd>.

<strong>BASH</strong>
```bash
$ hostname ctl
$ ip a
```

```bash
$ free -h
$ lscpu
$ df -h
```

```bash
$ lsb_release -a
$ ip -br addr
$ df -h
```

### Installing Suricata
Installing suricata from Ubuntu repository

<strong>BASH</strong>
```bash
$ sudo apt install suricata -y
```

```bash
$ suricata --build-info
```
<i>*As of the time of writing, the version installed is <kbd>Suricata 8.0.3 RELEASE</kbd></i>

Verify the installation using:
```bash
$ sudo systemctl status suricata
```

This should output the status of the Suricata service, it should display <kbd><strong>Active: active (running)</strong></kbd><br>
If the output is displaying <kbd><strong>Active: inactive (dead)</strong></kbd> or <kbd><strong>Active: failed</strong></kbd>, there's a huge chance that the Suricata installation is missing a ruleset.<br>

#### Inactive State Post-Install Troubleshooting
To fix this, we're using <kbd>suricata-update</kbd> to download a maintained ruleset.
The first step is to <strong>check the ruleset directory.</strong>

```bash
$ grep "default-rule-path" /etc/suricata/suricata.yaml
$ grep "suricata.rules" /etc/suricata/suricata.yaml
$ ls -l /var/lib/suricata/rules
```

If the output is 0, run:
```bash
# to check if suricata-update exists
$ suricata-update --version
# if the installation is missing suricata-update, install it using
$ sudo apt install suricata-update -y
# then, launch suricata-update
$ sudo suricata-update
```

Upon finishing the update, run:
```bash
$ ls -lh /var/lib/suricata/rules/
```

You should now see <kbd>suricata.rules</kbd> within the directory.

The next step is to configure <kbd>suricata.yaml</kbd> at <kbd>/etc/suricata/</kbd>.
You could run these commands to open suricata.yaml and then change the configuration of <kbd>- interface:</kbd> under the section "<kbd>af-packet</kbd>".

```bash
$ cd /etc/suricata/
```

Before changing the configuration, you'll need to do 2 things:
1. Figure out your network adapter using:

```bash
$ ip a
# Look for the adapter ID that has the "UP" status and take note of it.
```

2. Making a backup of suricata.yaml using:
```bash
$ cp suricata.yaml \ ./suricata.yaml.bak
```

After that is done, replace the interface configuration on the original suricata.yaml using:

```bash
$ sudo nano suricata.yaml
```
<i>Use the nano shortcuts shown below to look for "af-packets", then change the interface to the adapter ID that's currently being used for the server.</i>

Finally, verify the packet capture ability using:

```bash
$ sudo suricatasc -c iface-list
```

<i>This should output the the current interface it's capturing based on the previous suricata.yaml configuration on af-packets.</i>

### Testing Suricata
After making sure Suricata is installed and its services are running, try to generate a network activity by pinging a website, then checking:

```bash
$ sudo ls -lh /var/log/suricata/
$ sudo tail -f /var/log/suricata/eve.json
```

If there are new logs appearing, then Suricata is attached to the correct interface, it is able to capture packets, it's able to decode protocols and it's writing events to the json file.

### Generating an Alert
The next step is to generate an alert.

On its own, suricata should already be able to produce logs with the <kbd>"event_type"</kbd> of "alert" simply by detecting its own packet capture operation. the <kbd>"signature"</kbd> should be "SURICATA ...".

### Configuring Wazuh to Read eve.json
We're first going to check if eve.json has read permissions. This is to enable the ability of Wazuh getting the logs from eve.json, which will be our main objective.

```bash
$ ls -l /var/log/suricata/eve.json
# The output should be "-rw..."
```

Next, we're going to configure ossec.conf so that wazuh can read eve.json.

```bash
$ sudo cp /var/ossec/etc/ossec.conf /var/ossec/etc/ossec.conf.bak
$ sudo nano /var/ossec/etc/ossec.conf
```

Then, add a localfile section to the ending of the ossec.conf

```
<localfile>
  <log_format>json</log_format>
  <location>/var/log/suricata/eve.json</location>
</localfile>
```

Finally, restart the wazuh-manager service and check to see if it successfully runs

```bash
$ sudo systemctl restart wazuh-manager
```

If everything works out, open up the wazuh dashboard, go to the "Threat Hunting" menu, click on the "Events" tab and look for the keyword "suricata".<br>
<b>If it appears on the dashboard, it means the integration was a success.</b>