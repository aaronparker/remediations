# Adobe Acrobat - Reader Mode

Detect and configure the registry policy setting that forces Adobe Acrobat DC to open in Reader mode.

## Proactive remediation scripts

### Force Adobe Acrobat into Reader mode

- `Detect-AdobeAcrobatSettings.ps1` - detects whether Adobe Acrobat DC is configured to open in Reader mode
- `Remediate-AdobeAcrobatSettings.ps1` - configures Adobe Acrobat DC to open in Reader mode

Settings managed:

- Protected Mode enforcement (`bIsSCReducedModeEnforcedEx` = 1) under `HKLM:\SOFTWARE\Policies\Adobe\Acrobat Reader\DC\FeatureLockDown`
- Suppress in-product messages (`bDontShowMsgWhenViewingDoc` = 0) under `HKLM:\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cIPM`

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No

## References

- [Adobe Acrobat 64-bit for enterprises](https://helpx.adobe.com/enterprise/kb/acrobat-64-bit-for-enterprises.html)
