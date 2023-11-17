<#
    .SYNOPSIS
        Detects whether GPU is disabled in Microsoft Teams
        Run in user context

    .NOTES
        Author: Aaron Parker
        Twitter: @stealthpuppy
#>


try {
    $Config = Get-Content -Path "$Env:AppData\Microsoft\Teams\desktop-config.json" -ErrorAction "Stop" | `
        ConvertFrom-Json -ErrorAction "Stop"
    if ($Config.appPreferenceSettings.disableGpu -eq $true) {
        Write-Host "GPU hardware acceleration is disabled."
        exit 0
    }
    else {
        Write-Host "GPU hardware acceleration is enabled."
        exit 1
    }
}
catch {
    Write-Host $_.Exception.Message
    exit 1
}
