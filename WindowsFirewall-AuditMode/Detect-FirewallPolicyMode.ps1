<#
    .SYNOPSIS
        Detect whether Windows Firewall audit policies are enabled for Defender for Endpoint firewall reporting
        https://learn.microsoft.com/en-us/microsoft-365/security/defender-endpoint/host-firewall-reporting

        Looks for:
            Audit Filtering Platform Packet Drop
            Audit Filtering Platform Connection

    .NOTES
	    VERSION: 1.0
	    AUTHOR: Aaron Parker
	    TWITTER: @stealthpuppy

    .LINK
        http://stealthpuppy.com
#>
[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Output required by Proactive Remediations.")]
param ()

try {
    $Categories = "Filtering Platform Packet Drop,Filtering Platform Connection"
    $CurrentSettings = auditpol /get /subcategory:"$($Categories)" /r | ConvertFrom-Csv
    if ($CurrentSettings."Inclusion Setting" -ne "Failure") {
        Write-Host "Remediation Needed. $($CurrentSettings | ForEach-Object {$_.Subcategory + ":" + $_.'Inclusion Setting' + ";"})."
        exit 1
    }
    else {
        Write-Host "No remediation needed."
        exit 0
    }
}
catch {
    throw $_
}
