<#
    Disable third party co-installers that automatically install with device drivers
    https://learn.microsoft.com/en-us/windows-hardware/drivers/install/registering-a-device-specific-co-installer
#>

$Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Installer"
$Name = "DisableCoInstallers"

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
