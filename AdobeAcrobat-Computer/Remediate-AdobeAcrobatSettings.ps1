<#
    .SYNOPSIS
        Configures computer settings or policies for Adobe Acrobat and Reader

        # https://www.adobe.com/devnet-docs/acrobatetk/tools/PrefRef/Windows/JSPrefs.html
        # https://www.adobe.com/devnet-docs/acrobatetk/tools/PrefRef/Windows/FeatureLockDown.html
#>
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Output required by Proactive Remediations.")]
param()

$Settings = @"
[
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown",
        "name": "bDisableJavaScript",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Adobe Acrobat\\DC\\FeatureLockDown",
        "name": "bDisableJavaScript",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown",
        "name": "bAcroSuppressUpsell",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Acrobat\\DC\\FeatureLockDown",
        "name": "bAcroSuppressUpsell",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown\\cServices",
        "name": "bBoxConnectorEnabled",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Acrobat\\DC\\FeatureLockDown\\cServices",
        "name": "bBoxConnectorEnabled",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown\\cServices",
        "name": "bDropboxConnectorEnabled",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Acrobat\\DC\\FeatureLockDown\\cServices",
        "name": "bDropboxConnectorEnabled",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown\\cServices",
        "name": "bOneDriveConnectorEnabled",
        "value": 0,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Acrobat\\DC\\FeatureLockDown\\cServices",
        "name": "bOneDriveConnectorEnabled",
        "value": 0,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown\\cServices",
        "name": "bGoogleDriveConnectorEnabled",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Acrobat\\DC\\FeatureLockDown\\cServices",
        "name": "bGoogleDriveConnectorEnabled",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Acrobat Reader\\DC\\FeatureLockDown",
        "name": "bIsSCReducedModeEnforcedEx",
        "value": 1,
        "type": "Dword"
    },
    {
        "path": "HKLM:\\SOFTWARE\\Policies\\Adobe\\Adobe Acrobat\\DC\\FeatureLockDown\\cIPM",
        "name": "bDontShowMsgWhenViewingDoc",
        "value": 0,
        "type": "Dword"
    }
]
"@ | ConvertFrom-Json

[System.Int16] $Script = 0
[System.Int16] $Result = 0

foreach ($Setting in $Settings) {
    try {
        if (!(Test-Path -Path $Setting.path -ErrorAction "SilentlyContinue")) {
            $params = @{
                Path        = $Setting.path
                Type        = "RegistryKey"
                Force       = $True
                ErrorAction = "SilentlyContinue"
            }
            $SettingResult = New-Item @params
            if ("Handle" -in ($SettingResult | Get-Member -ErrorAction "SilentlyContinue" | Select-Object -ExpandProperty "Name")) { $SettingResult.Handle.Close() }
        }
        $params = @{
            Path        = $Setting.path
            Name        = $Setting.name
            Value       = $Setting.value
            Type        = $Setting.type
            Force       = $True
            ErrorAction = "SilentlyContinue"
        }
        Set-ItemProperty @params > $null
        $Result = 0
    }
    catch {
        $Result = 1
        $Script = 1
    }
    Write-Host "$Result $($Setting.path)"
}
exit $Script
