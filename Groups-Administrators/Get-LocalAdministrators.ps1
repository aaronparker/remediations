[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Output required by Proactive Remediations.")]
param()

#use the old net localgroup command to get members of the local Administrators group,
# then parse the text output, excluding the built-in Administrator user and Domain Admins group
$LocalAdmins = net localgroup administrators | `
    Where-Object { $_ -and $_ -notmatch "command completed successfully" -and $_ -notmatch '^Administrator$' -and $_ -notmatch 'Domain Admins' } | `
    Select-Object -Skip 4

#Convert the text to an array
$LocalAdmins = $LocalAdmins.Split([Environment]::NewLine) | Where-Object { $_ -ne "" }

#Example of looping through the array
foreach ($user in $LocalAdmins) {
    Write-Host "$user is a local admin"
}
