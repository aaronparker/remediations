<#
    .SYNOPSIS
        Enable Windows Firewall audit policies for Defender for Endpoint firewall reporting
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
    auditpol /set /subcategory:"$($Categories)" /failure:enable
    exit 0
}
catch {
    throw $_
}
