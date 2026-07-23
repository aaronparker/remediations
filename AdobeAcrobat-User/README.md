# Adobe Acrobat and Reader - User Settings

Detect and configure user-level registry settings for Adobe Acrobat Reader DC and Adobe Acrobat DC.

## Proactive remediation scripts

### Disable default PDF application prompt

- `Detect-AdobeReaderSettings.ps1` - detects whether the prompt "Make Adobe Acrobat my default PDF application" has been suppressed for the current user
- `Remediate-AdobeReaderSettings.ps1` - suppresses the "Make Adobe Acrobat my default PDF application" prompt for the current user

Settings managed:

- Disable default PDF ownership prompt (`iAppDoNotTakePDFOwnershipAtLaunchWin10` = 1) under `HKCU:\SOFTWARE\Adobe\Acrobat Reader\DC\AVAlert\cCheckbox` and `HKCU:\SOFTWARE\Adobe\Adobe Acrobat\DC\AVAlert\cCheckbox`

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - Yes
