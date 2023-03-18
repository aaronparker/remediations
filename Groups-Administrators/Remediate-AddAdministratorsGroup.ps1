<#
    Adds the primary user of the device to the local Administrators group
#>
[CmdletBinding()]
param()

function Get-EnrollmentsRegistryKey {
    try {
        $EnrollmentsKey = "HKLM:\SOFTWARE\Microsoft\Enrollments\"
        $MatchingKey = foreach ($Key in (Get-ChildItem -Path $EnrollmentsKey | Where-Object { $_.PSIsContainer -eq $true })) {
            $Key | Where-Object { ($_.Property -match "ProviderID") -and ($_.Property -match "UPN") -and ($_.Property -match "AADTenantID") }
        }
    }
    catch {
        $MatchingKey = $null
        throw "Failed to return key."
    }
    Write-Output -InputObject $MatchingKey
}

$MatchingKey = Get-EnrollmentsRegistryKey
if ($null -ne $MatchingKey) {
    $Upn = $MatchingKey.GetValue("UPN")
    if ($null -ne $Upn) {
        if (($MatchingKey.GetValue("ProviderID") -match "MS DM Server") -and ($MatchingKey.GetValue("AADResourceID") -match "https://manage.microsoft.com/")) {
            try {
                $String = "Attempting to add $Upn to Administrators."
                $params = @{
                    Group       = "Administrators"
                    Member      = "AzureAD\$Upn"
                    ErrorAction = "Stop"
                }
                Add-LocalGroupMember @params
            }
            catch {
                $String += " $($_.Exception.Message)"
                Write-Output -InputObject $String
                exit 1
            }
            $String += " Successfully added $Upn to Administrators."
            Write-Output -InputObject $String
            exit 0
        }
        else {
            "No matching values for ProviderID and AADResourceID."
            exit 1
        }
    }
    else {
        "No value for UPN. Could be multi-user / shared device."
        exit 0
    }
}
else {
    "Failed to return a matching key with ProviderID and AADResourceID."
    exit 0
}
