<#
    Determine whether the primary user of the device is in the Administrators group
    ! Need to find a way to turn domain\username into UPN for detection and match against the primary user
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
