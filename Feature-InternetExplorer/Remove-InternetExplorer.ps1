<#
        .SYNOPSIS
            Detects Internet Explorer
#>
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Output required by Proactive Remediations.")]
param()

try {
    $params = @{
        Name        = "Browser.InternetExplorer~~~~0.0.11.0"
        Online      = $true
        ErrorAction = "Stop"
    }
    $Result = Remove-WindowsCapability @params
    Write-Host "Removed Browser.InternetExplorer~~~~0.0.11.0. Restart needed: $($Result.RestartNeeded)"
    exit 0
}
catch {
    Write-Host $_.Exception.Message
    exit 1
}
