# Internet Explorer

Detect whether Internet Explorer is installed as a Windows optional feature, and remove it.

## Proactive remediation scripts

### Detect and remove Internet Explorer

- `Detect-InternetExplorer.ps1` - checks whether the `Browser.InternetExplorer~~~~0.0.11.0` Windows capability is present on the device
- `Remove-InternetExplorer.ps1` - removes the `Browser.InternetExplorer~~~~0.0.11.0` Windows capability using `Remove-WindowsCapability`

A restart may be required after the capability is removed.

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No
