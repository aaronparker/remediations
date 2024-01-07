<#
    Enable 'Local Security Authority (LSA) protection'
    https://learn.microsoft.com/en-us/windows-server/security/credentials-protection-and-management/configuring-additional-lsa-protection
#>

$Key = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$Name = "RunAsPPL"

# The value we are expecting
[System.Int32] $Value = 1

# Set the current value
$params = @{
    Path        = $Key
    Name        = $Name
    Value       = $Value
    ErrorAction = "Stop"
}
Set-ItemProperty @params | Out-Null

$params = @{
    Path = $Key
    Name = $Name
}
$Property = Get-ItemProperty @params
if ($Property.$Name -eq $Value) {
    return 0
}
else {
    return 1
}
