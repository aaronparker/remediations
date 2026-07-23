# Disable Domain Credentials Storage

Detect and configure the security policy setting "Network access: Do not allow storage of passwords and credentials for network authentication".

## Proactive remediation scripts

### Disable domain credential storage

- `Detect-DisableDomainCreds.ps1` - detects whether the storage of network passwords and credentials is disabled
- `Remeditate-DisableDomainCreds.ps1` - sets the registry value to disable storage of network passwords and credentials

Settings managed:

- `DisableDomainCreds` = 1 under `HKLM:\SYSTEM\CurrentControlSet\Control\Lsa`

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No

## References

- [Network access: Do not allow storage of passwords and credentials for network authentication](https://learn.microsoft.com/en-us/windows/security/threat-protection/security-policy-settings/network-access-do-not-allow-storage-of-passwords-and-credentials-for-network-authentication)
