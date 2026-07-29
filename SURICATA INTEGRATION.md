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