# AppX Packages

Detect and remediate AppX packages that should be removed from the system.

Also see removing in-box AppX applications during Windows Autopilot with [Windows Customised Defaults](https://stealthpuppy.com/image-customise/).

## Proactive remediation scripts

### Remove blocked AppX packages

- `Detect-BlockedAppXPackages.ps1` - detects whether any packages from the blocked list are installed on the device
- `Remediate-BlockedAppXPackages.ps1` - removes all packages from the blocked list, including provisioned packages when running with elevated privileges

The default blocked list includes:

- `MicrosoftTeams_8wekyb3d8bbwe` - Microsoft Teams (Windows 11 inbox)
- `Microsoft.XboxApp_8wekyb3d8bbwe` - Xbox Console Companion
- `Microsoft.BingNews_8wekyb3d8bbwe` - Microsoft News
- `Microsoft.GamingApp_8wekyb3d8bbwe` - Microsoft Xbox
- `Clipchamp.Clipchamp_yxz26nhyzhsrt` - Clipchamp (Windows 11 inbox)

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No
