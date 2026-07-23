# Local Security Authority Protection

Detect and configure the registry setting to enable Local Security Authority (LSA) protection, which runs the LSA process as a Protected Process Light (PPL).

## Proactive remediation scripts

### Enable LSA protection

- `Detect-LsaProtection.ps1` - detects whether LSA protection is enabled
- `Remeditate-LsaProtection.ps1` - enables LSA protection by setting the required registry value

Settings managed:

- `RunAsPPL` = 1 under `HKLM:\SYSTEM\CurrentControlSet\Control\Lsa`

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No

## References

- [Configuring additional LSA protection](https://learn.microsoft.com/en-us/windows-server/security/credentials-protection-and-management/configuring-additional-lsa-protection)
