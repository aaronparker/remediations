# Microsoft Teams GPU Hardware Acceleration

Detect and configure whether GPU hardware acceleration is disabled in the Microsoft Teams client configuration.

## Proactive remediation scripts

### Disable GPU hardware acceleration in Microsoft Teams

- `Detect-MicrosoftTeamsGPU.ps1` - detects whether GPU hardware acceleration is disabled in the Microsoft Teams desktop client configuration
- `Remediate-MicrosoftTeamsGPU.ps1` - disables GPU hardware acceleration by setting `disableGpu` to `true` in the Teams `desktop-config.json` file

The Teams configuration file is located at `%AppData%\Microsoft\Teams\desktop-config.json`.

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - Yes
