<#
    Force an update for the Microsoft 365 Apps
#>

#region Show a popup notification
<#
    Source:
    https://msendpointmgr.com/2020/06/25/endpoint-analytics-proactive-remediations/
#>
function Show-ToastNotification {
    param (
        [System.Xml.XmlDocument] $Toast
    )

    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

    # Load the notification into the required format
    $ToastXML = New-Object -TypeName "Windows.Data.Xml.Dom.XmlDocument"
    $ToastXML.LoadXml($Toast.OuterXml)

    try {
        # Display the toast notification
        [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($App).Show($ToastXml)
    }
    catch {
        Write-Warning -Message "Something went wrong when displaying the toast notification. Ensure the script is running as the logged on user."
    }
}

<# Setting image variables
$LogoImageUri = "https://azurefilesnorway.blob.core.windows.net/brandingpictures/Notifications/SCConfigMgr_Symbol_512.png"
$HeroImageUri = "https://azurefilesnorway.blob.core.windows.net/brandingpictures/Notifications/MSEndpoingMgrHeroImage.png"
$LogoImage = "$env:TEMP\ToastLogoImage.png"
$HeroImage = "$env:TEMP\ToastHeroImage.png"

#Fetching images from uri
Invoke-WebRequest -Uri $LogoImageUri -OutFile $LogoImage
Invoke-WebRequest -Uri $HeroImageUri -OutFile $HeroImage
#>

# Check for required entries in registry for when using Powershell as application for the toast
# Register the AppID in the registry for use with the Action Center, if required
$RegPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings"
$App = "{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe"

# Creating registry entries if they don't exist
if (-not(Test-Path -Path "$RegPath\$App")) {
    New-Item -Path "$RegPath\$App" -Force > $null
    New-ItemProperty -Path "$RegPath\$App" -Name 'ShowInActionCenter' -Value 1 -PropertyType 'DWORD' > $null
}

# Make sure the app used with the action center is enabled
if ((Get-ItemProperty -Path "$RegPath\$App" -Name 'ShowInActionCenter' -ErrorAction SilentlyContinue).ShowInActionCenter -ne '1') {
    New-ItemProperty -Path "$RegPath\$App" -Name 'ShowInActionCenter' -Value 1 -PropertyType 'DWORD' -Force > Out-Null
}

#Defining the Toast notification settings
#ToastNotification Settings
$Scenario = "reminder" # <!-- Possible values are: reminder | short | long -->

# Load Toast Notification text
$AttributionText = "stealthpuppy Service Desk"
$HeaderText = "Microsoft 365 Apps Update Required"
$TitleText = "Please save your documents"
$BodyText1 = "To protect your device, the Microsoft 365 Apps will now update. Restarting your applications may be required."

# Formatting the toast notification XML
[System.Xml.XmlDocument]$Toast = @"
<toast scenario="$Scenario">
    <visual>
    <binding template="ToastGeneric">
        <text placement="attribution">$AttributionText</text>
        <text>$HeaderText</text>
        <group>
            <subgroup>
                <text hint-style="title" hint-wrap="true" >$TitleText</text>
            </subgroup>
        </group>
        <group>
            <subgroup>
                <text hint-style="body" hint-wrap="true" >$BodyText1</text>
            </subgroup>
        </group>
    </binding>
    </visual>
    <actions>
        <action activationType="system" arguments="dismiss" content="$DismissButtonContent"/>
    </actions>
</toast>
"@
#endregion

try {
    # Find the OfficeC2RClient.exe executable, show the toast notification and start the update
    $Configuration = Get-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun\Configuration" -ErrorAction "SilentlyContinue"
    if (Test-Path -Path "$($Configuration.ClientFolder)\OfficeC2RClient.exe") {
        $params = @{
            FilePath     = "$($Configuration.ClientFolder)\OfficeC2RClient.exe"
            ArgumentList = "/update user"
            Wait         = $true
            PassThru     = $true
        }
        Show-ToastNotification -Toast $Toast
        $result = Start-Process @params
        exit $result.ExitCode
    }
}
catch {
    throw $_
}
