<#
    Disable third party co-installers that automatically install with device drivers
    https://learn.microsoft.com/en-us/windows-hardware/drivers/install/registering-a-device-specific-co-installer
#>

$Key = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Installer"
$Name = "DisableCoInstallers"

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
    exit 0
}
else {
    exit 1
}
