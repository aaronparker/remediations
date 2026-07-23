# Disable Device Co-Installers

Detect and configure the registry setting to disable third-party co-installers that automatically install alongside device drivers.

## Proactive remediation scripts

### Disable co-installers

- `Detect-DisableCoInstallers.ps1` - detects whether third-party device co-installers are disabled
- `Remeditate-DisableCoInstallers.ps1` - sets the registry value to disable third-party device co-installers

Settings managed:

- `DisableCoInstallers` = 1 under `HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Installer`

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No

## References

- [Registering a device-specific co-installer](https://learn.microsoft.com/en-us/windows-hardware/drivers/install/registering-a-device-specific-co-installer)
