<#
    Compare the installed version of the Microsoft 365 Apps against the minimum required version
    # https://gist.github.com/nicolonsky/b04dd77129577f782178c0c049344101
#>

# List the minimum version for each update channel
# Use Evergreen to return the latest update versions https://stealthpuppy.com/evergreen
#  Get-EvergreenApp -Name Microsoft365Apps
$VersionsJson = @"
[
    {
        "Channel": "BetaChannel",
        "Version": "16.0.16310.20000",
        "Guid": "5440fd1f-7ecb-4221-8110-145efaa6372f"
    },
    {
        "Channel": "Current",
        "Version": "16.0.16130.20306",
        "Guid": "492350f6-3a01-4f97-b9c0-c7c6ddf67d60"
    },
    {
        "Channel": "CurrentPreview",
        "Version": "16.0.16227.20158",
        "Guid": "64256afe-f5d9-4f86-8936-8840a6a4f5be"
    },
    {
        "Channel": "MonthlyEnterprise",
        "Version": "16.0.16026.20238",
        "Guid": "55336b82-a18d-4dd6-b5f6-9e5095c314a6"
    },
    {
        "Channel": "PerpetualVL2019",
        "Version": "16.0.10396.20023",
        "Guid": "f2e724c1-748f-4b47-8fb8-8e0d210e9208"
    },
    {
        "Channel": "PerpetualVL2021",
        "Version": "16.0.14332.20481",
        "Guid": "5030841d-c919-4594-8d2d-84ae4f96e58e"
    },
    {
        "Channel": "SemiAnnual",
        "Version": "16.0.15601.20578",
        "Guid": "7ffbc6bf-bc32-4f92-8982-f9dd17fd3114"
    },
    {
        "Channel": "SemiAnnualPreview",
        "Version": "16.0.16130.20306",
        "Guid": "b8f9b850-328d-4355-9145-c59439a0c4cf"
    }
]
"@

try {
    # Read the registry to compare the installed version against the required version
    $Versions = $VersionsJson | ConvertFrom-Json
    $Configuration = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" -ErrorAction "SilentlyContinue"
    $Channel = $Versions | Where-Object { $_.Guid -eq $Configuration.AudienceId }

    # Compare version and output result
    if ([System.String]::IsNullOrEmpty($Configuration.VersionToReport)) {
        Write-Output -InputObject "Microsoft 365 Apps not detected"
    }
    else {
        if ([System.Version]$Configuration.VersionToReport -lt [System.Version]$Channel.Version) {
            Write-Output -InputObject "Installed version: $($Configuration.VersionToReport), less than minimum version: $($Channel.Version). Update required."
            exit 1
        }
        else {
            Write-Output -InputObject "No update required"
            exit 0
        }
    }
}
catch {
    throw $_
}
