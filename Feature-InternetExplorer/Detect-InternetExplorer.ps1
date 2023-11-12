<#
        .SYNOPSIS
            Detects Internet Explorer
#>
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Output required by Proactive Remediations.")]
param()

if ((Get-WindowsCapability -Online -Name "Browser.InternetExplorer~~~~0.0.11.0").State -eq "NotPresent") {
    Write-Host "Browser.InternetExplorer~~~~0.0.11.0 package is not present."
    exit 0
}
else {
    Write-Host "Browser.InternetExplorer~~~~0.0.11.0 package is present."
    exit 1
}
