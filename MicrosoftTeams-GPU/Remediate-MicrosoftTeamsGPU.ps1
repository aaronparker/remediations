<#
    .SYNOPSIS
        Detects whether GPU is disabled in Microsoft Teams
        Run in user context

    .NOTES
        Author: Aaron Parker
        Twitter: @stealthpuppy
#>


try {
    $FilePath = "$Env:AppData\Microsoft\Teams\desktop-config.json"
    $Config = Get-Content -Path $FilePath -ErrorAction "Stop" | `
        ConvertFrom-Json -ErrorAction "Stop"
    $Config.appPreferenceSettings.disableGpu = $true
    $Json = $Config | ConvertTo-Json -Compress -ErrorAction "Stop"
    $Utf8NoBomEncoding = New-Object -TypeName "System.Text.UTF8Encoding" -ArgumentList $false
    [System.IO.File]::WriteAllLines($FilePath, $Json, $Utf8NoBomEncoding)
    exit 0
}
catch {
    Write-Host $_.Exception.Message
    exit 1
}
