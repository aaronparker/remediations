# Antivirus Product Report

Reports the installed antivirus product on the device. Intended for use as a detection-only Proactive Remediation to surface antivirus product information in the Intune console.

## Proactive remediation scripts

### Report installed antivirus product

- `Detect-AntivirusProduct.ps1` - queries the WMI `root/SecurityCenter2` namespace for the `AntiVirusProduct` class and outputs the display name and reporting executable path of the registered antivirus product

No remediation script is used. The detection script exits with code 0 when an antivirus product is found and outputs its name, or exits with code 1 when no product is detected.

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No
