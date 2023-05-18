# Host firewall reporting in Microsoft Defender for Endpoint

Scripts to be used to enable Windows Firewall audit policies for Microsoft Defender for Endpoint: [Host firewall reporting in Microsoft Defender for Endpoint](https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/host-firewall-reporting).

## Proactive remediation scripts

### Firewall scripts

* `Detect-FirewallPolicyMode.ps1` - detect the required policy settings
* `Remediate-FirewallPolicyMode.ps1` - enable the required policy settings
* `Unset-FirewallPolicyMode.ps1` - unset audit policy settings which cna be run as a detection script

Run with the following settings:

* `Run script in 64-bit PowerShell` - Yes
* `Run this script using the logged-on credentials` - No
