<#
    .SYNOPSIS
        Remove audit mode for the specified categories
#>

$Categories = "Filtering Platform Packet Drop,Filtering Platform Connection"
auditpol /set /subcategory:"$($Categories)" /success:disable /failure:disable
