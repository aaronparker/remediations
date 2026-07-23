# Automatic Time Zone Update

Detect and configure the `tzautoupdate` service to enable automatic time zone updates based on device location.

## Proactive remediation scripts

### Enable the tzautoupdate service

- `Detect-tzautoupdate.ps1` - detects whether the `tzautoupdate` service is configured to start automatically (Start = 3)
- `Remeditate-tzautoupdate.ps1` - sets the `tzautoupdate` service startup value to automatic and starts the service

Settings managed:

- `Start` = 3 under `HKLM:\SYSTEM\CurrentControlSet\Services\tzautoupdate`

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No
