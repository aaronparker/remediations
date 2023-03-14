<#
    .SYNOPSIS
        Main Pester function tests.
#>
[OutputType()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "", Justification="This OK for the tests files.")]
param ()

BeforeDiscovery {
    # TestCases are splatted to the script so we need hashtables
    $Scripts = Get-ChildItem -Path "$env:GITHUB_WORKSPACE" -Recurse -Include ".*.ps1"
    $TestCases = $Scripts | ForEach-Object { @{file = $_ } }
}

BeforeAll {
}

Describe "General project validation" {
    It "Script <file.Name> should exist" -TestCases $TestCases {
        param ($file)
        $file.FullName | Should -Exist
    }

    It "Script <file.Name> should be valid PowerShell" -TestCases $TestCases {
        param ($file)
        $contents = Get-Content -Path $file.FullName -ErrorAction "Stop"
        $errors = $null
        $null = [System.Management.Automation.PSParser]::Tokenize($contents, [ref]$errors)
        $errors.Count | Should -Be 0
    }
}
