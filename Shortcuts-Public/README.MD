# Shortcut

Scripts to create a shortcut or remove target shortcuts. Can be used to create shortcuts (typically to an application) in the Start menu / desktop etc. or remove shortcuts. Can also be used in Proactive remediations to remove shortcuts from target locations.

## Proactive remediation scripts

### Detect and remove Public desktop shortcuts

* `Detect-PublicDesktopShortcuts.ps1` - detect whether there are shortcuts on the Public Desktop: `C:\Users\Public\Desktop`
* `Remediate-PublicDesktopShortcuts.ps1` - removes shortcuts from the Public Desktop

Run with the following settings:

* `Run script in 64-bit PowerShell` - Yes
* `Run this script using the logged-on credentials` - No
