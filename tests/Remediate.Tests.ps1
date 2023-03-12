<#
    .SYNOPSIS
        Public Pester function tests.
#>
[OutputType()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "", Justification = "This OK for the tests files.")]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSAvoidUsingWriteHost", "", Justification = "Outputs to log host.")]
param ()

BeforeDiscovery {
    # TestCases are splatted to the script so we need hashtables
    $Scripts = Get-ChildItem -Path "$env:GITHUB_WORKSPACE" -Recurse -Include "Remediate*.ps1"
    $TestCases = $Scripts | ForEach-Object { @{file = $_ } }
}

Describe -Tag "Detect" -Name "<Script.Name> runs OK" -ForEach $TestCases {
    BeforeAll {
        # Renaming the automatic $_ variable to $application to make it easier to work with
        $Script = $_
    }

    Context "Script should run without issue" {
        It "Should not throw" {
            { & $Script.FullName } | Should -Not -Throw
        }
    }
}