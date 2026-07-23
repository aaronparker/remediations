# TLS 1.2 Configuration

Detect and configure the registry settings required to enable TLS 1.2 for .NET Framework applications and the Windows SCHANNEL provider.

## Proactive remediation scripts

### Enable TLS 1.2

- `Detect-NetTls12.ps1` - detects whether the required TLS 1.2 registry settings are configured for .NET Framework and SCHANNEL
- `Remediate-NetTls12.ps1` - configures the required TLS 1.2 registry settings for .NET Framework and SCHANNEL

Settings managed under `HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319` and `HKLM:\SOFTWARE\WOW6432Node\Microsoft\.NETFramework\v4.0.30319`:

- `SystemDefaultTlsVersions` = 1
- `SchUseStrongCrypto` = 1

Settings managed under `HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server` and `\Client`:

- `Enabled` = 1
- `DisabledByDefault` = 0

The scripts automatically re-launch in a 64-bit PowerShell session when running in a 32-bit context.

Run with the following settings:

- `Run script in 64-bit PowerShell` - Yes
- `Run this script using the logged-on credentials` - No

## Other files

- `Keys.json` - JSON file defining the TLS 1.2 registry keys and values
