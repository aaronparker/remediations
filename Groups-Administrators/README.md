# Local Administrators Group

Detect and remediate the membership of the local Administrators group by adding the primary Intune-enrolled user.

## Proactive remediation scripts

### Add primary user to Administrators group

- `Detect-AddAdministratorsGroup.ps1` - detects whether the primary Intune-enrolled user of the device is a member of the local Administrators group
- `Remediate-AddAdministratorsGroup.ps1` - adds the primary Intune-enrolled user to the local Administrators group

The primary user is determined by reading the `UPN` value from the device's Intune enrollment registry key at `HKLM:\SOFTWARE\Microsoft\Enrollments`.

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No

## Other scripts

- `Get-LocalAdministrators.ps1` - returns the current membership of the local Administrators group
