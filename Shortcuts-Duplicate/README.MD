# Shortcut

Scripts to create a shortcut or remove target shortcuts. Can be used to create shortcuts (typically to an application) in the Start menu / desktop etc. or remove shortcuts. Can also be used in Proactive remediations to remove shortcuts from target locations.

## Proactive remediation scripts

### Detect and remove duplicate shortcuts

* `Detect-DuplicateShortcuts.ps1` - detect duplicate Microsoft Edge and Teams shortcuts
* `Remediate-DuplicateShortcuts.ps1` - remove duplicate Microsoft Edge and Teams shortcuts

Run with the following settings:

* `Run script in 64-bit PowerShell` - Yes
* `Run this script using the logged-on credentials` - Yes

When shortcuts are removed a notification will be shown to the user:

![Removed shortcuts notification](img/removedshortcutsnotification.png)
