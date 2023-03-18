<#
    .SYNOPSIS
        Create a shortcut to an application.

    .NOTES
        Author: Aaron Parker
        Twitter: @stealthpuppy

    .LINK
        https://stealthpuppy.com
#>
[CmdletBinding(SupportsShouldProcess = $True)]
param()

function Get-KnownFolderPath {
    <#
        .SYNOPSIS
            Gets a known folder's path using GetFolderPath.
        .PARAMETER KnownFolder
            The known folder whose path to get. Validates set to ensure only knwwn folders are passed.
        .NOTES
            https://stackoverflow.com/questions/16658015/how-can-i-use-powershell-to-call-shgetknownfolderpath
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateSet('AdminTools', 'ApplicationData', 'CDBurning', 'CommonAdminTools', 'CommonApplicationData', `
                'CommonDesktopDirectory', 'CommonDocuments', 'CommonMusic', 'CommonOemLinks', 'CommonPictures', `
                'CommonProgramFiles', 'CommonProgramFilesX86', 'CommonPrograms', 'CommonStartMenu', 'CommonStartup', `
                'CommonTemplates', 'CommonVideos', 'Cookies', 'Desktop', 'DesktopDirectory', 'Favorites', `
                'Fonts', 'History', 'InternetCache', 'LocalApplicationData', 'LocalizedResources', 'MyComputer', `
                'MyDocuments', 'MyMusic', 'MyPictures', 'MyVideos', 'NetworkShortcuts', 'Personal', 'PrinterShortcuts', `
                'ProgramFiles', 'ProgramFilesX86', 'Programs', 'Recent', 'Resources', 'SendTo', `
                'StartMenu', 'Startup', 'System', 'SystemX86', 'Templates', 'UserProfile', 'Windows')]
        [System.String] $KnownFolder
    )

    $folder = [Environment]::GetFolderPath($KnownFolder)
    Write-Verbose "Location for $KnownFolder is $folder."
    Write-Output -InputObject $folder
}

function New-Shortcut {
    [CmdletBinding(SupportsShouldProcess = $True)]
    param (
        [System.String] $Path,
        [System.String] $Target,
        [System.String] $Arguments,
        [System.String] $WorkingDirectory,
        [System.String] $WindowStyle = 1,
        [System.String] $Hotkey,
        [System.String] $Icon,
        [System.String] $Description
    )
    try {
        if ($PSCmdlet.ShouldProcess($Path, ("Creating shortcut '{0}'" -f $Path))) {
            Write-Verbose -Message "Creating shortcut $($Path)."
            $shell = New-Object -ComObject ("WScript.Shell")
            $shortCut = $shell.CreateShortcut($Path)
            $shortCut.TargetPath = $Target
            $shortCut.Arguments = $Arguments
            $shortCut.WorkingDirectory = $WorkingDirectory
            $shortCut.WindowStyle = $WindowStyle
            $shortCut.Hotkey = $Hotkey
            $shortCut.IconLocation = $Icon
            $shortCut.Description = $Description
            $shortCut.Save()
        }
        Write-Output -InputObject $Path
    }
    catch {
        throw $_
    }
}

# Shortcut locations array
$Paths = @($(Get-KnownFolderPath -KnownFolder "Desktop"), "$(Get-KnownFolderPath -KnownFolder "StartMenu")\Programs")

# Create the shortcuts
foreach ($Path in $Paths) {
    if (Test-Path -Path "$Path\Microsoft Teams.lnk") {
        continue
    }
    else {
        # Create New-Shortcut arguments
        $shortcutArgs = @{
            Path             = "$Path\Microsoft Teams.lnk"
            Target           = "$env:LocalAppData\Microsoft\Teams\Update.exe"
            Arguments        = '--processStart "Teams.exe"'
            WorkingDirectory = "$env:LocalAppData\Microsoft\Teams"
            WindowStyle      = 1
            Hotkey           = ""
            Icon             = "$env:LocalAppData\Microsoft\Teams\Update.exe, 0"
            Description      = "Microsoft Teams"
        }
        $Output += "$($shortcutArgs.Path)\"
        New-Shortcut @shortcutArgs
    }
    Write-Output -InputObject "Created shortcuts:`n$($Output -join "\" -replace "\\", "`n")"
    exit 0
}
