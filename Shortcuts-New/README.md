# New Shortcuts

Detect whether required application shortcuts exist and create them if missing.

## Proactive remediation scripts

### Create Microsoft Teams shortcuts

- `Detect-NewShortcut.ps1` - detects whether a Microsoft Teams shortcut exists on the user's desktop and in the Start menu Programs folder
- `Remediate-NewShortcut.ps1` - creates a Microsoft Teams shortcut on the user's desktop and in the Start menu Programs folder, targeting `%LocalAppData%\Microsoft\Teams\Update.exe`

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - Yes
