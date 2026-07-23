# Adobe Acrobat and Reader - Computer Settings

Detect and configure computer-level policy settings for Adobe Acrobat Reader DC and Adobe Acrobat DC using registry keys under `HKLM:\SOFTWARE\Policies\Adobe`.

## Proactive remediation scripts

### Adobe Acrobat and Reader computer settings

- `Detect-AdobeAcrobatSettings.ps1` - detects whether the required computer policy settings are applied for Adobe Acrobat Reader DC and Adobe Acrobat DC
- `Remediate-AdobeAcrobatSettings.ps1` - configures the required computer policy settings for Adobe Acrobat Reader DC and Adobe Acrobat DC

Settings managed:

- Disable JavaScript execution (`bDisableJavaScript`)
- Suppress upsell prompts (`bAcroSuppressUpsell`)
- Cloud storage connectors - Box enabled, Dropbox enabled, OneDrive disabled, Google Drive enabled (`bBoxConnectorEnabled`, `bDropboxConnectorEnabled`, `bOneDriveConnectorEnabled`, `bGoogleDriveConnectorEnabled`)
- Enable Protected Mode enforcement (`bIsSCReducedModeEnforcedEx`)
- Disable in-product messages (`bDontShowMsgWhenViewingDoc`)

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No

## References

- [Adobe Acrobat Feature Lockdown preferences](https://www.adobe.com/devnet-docs/acrobatetk/tools/PrefRef/Windows/FeatureLockDown.html)
- [Adobe JavaScript preferences](https://www.adobe.com/devnet-docs/acrobatetk/tools/PrefRef/Windows/JSPrefs.html)
