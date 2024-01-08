<#
    Enable 'Local Security Authority (LSA) protection'
    https://learn.microsoft.com/en-us/windows-server/security/credentials-protection-and-management/configuring-additional-lsa-protection
#>

$Key = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$Name = "RunAsPPL"

# The value we are expecting
[System.Int32] $Value = 1

# Get the current value
try {
    $params = @{
        Path        = $Key
        Name        = $Name
        ErrorAction = "SilentlyContinue"
    }
    $Property = Get-ItemProperty @params
}
catch {
    throw [System.Management.Automation.ItemNotFoundException] "Failed to retrieve value for $Name with $($_.Exception.Message)"
}

if ($Property.$Name -eq $Value) {
    exit 0
}
else {
    exit 1
}
