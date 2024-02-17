Add-Type -AssemblyName PresentationFramework

$currentPid = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$principal = new-object System.Security.Principal.WindowsPrincipal($currentPid)
$adminRole=[System.Security.Principal.WindowsBuiltInRole]::Administrator

if ($principal.IsInRole($adminRole))
{
    Clear-Host
}
else
{
    $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";
    $newProcess.Arguments = $myInvocation.MyCommand.Definition;
    $newProcess.Verb = "runas";
    [System.Diagnostics.Process]::Start($newProcess);
    Break
}

$systemInfo = Get-CimInstance Win32_OperatingSystem
$processorInfo = Get-CimInstance Win32_Processor
$memoryInfo = Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum

$ansiBlue = [char]27 + '[1;34m'
$ansiReset = [char]27 + '[0m'

Write-Host "$($ansiBlue)$env:USERNAME$($ansiReset)@$($ansiBlue)$env:COMPUTERNAME$($ansiReset)"
Write-Host "----------------------"
Write-Host "$($ansiBlue)OS$($ansiReset): $($systemInfo.Caption) $($systemInfo.Version)"
Write-Host "$($ansiBlue)Host$($ansiReset): $($systemInfo.Manufacturer)"
Write-Host "$($ansiBlue)Kernel$($ansiReset): $($systemInfo.BuildNumber)"
Write-Host "$($ansiBlue)Uptime$($ansiReset): $([TimeSpan]::FromSeconds(($([DateTime]::Now) - $systemInfo.LastBootUpTime).TotalSeconds).ToString("d\d\:h\h\:mm\m\:ss\s"))"
Write-Host "$($ansiBlue)CPU$($ansiReset): $($processorInfo.Name) ($($processorInfo.NumberOfCores) cores) @ $($processorInfo.MaxClockSpeed / 1000)GHz"
Write-Host "$($ansiBlue)Memory$($ansiReset): $([math]::Round($memoryInfo.Sum / 1GB, 2)) GiB / $([math]::Round($systemInfo.TotalVisibleMemorySize / 1GB, 2)) GiB"
Write-Host ""   

# Define XAML markup directly
$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="nibfy.github.io/win" ResizeMode="NoResize" Height="400" Width="570">
   <Window.Resources>
        <Style x:Key="MyButton" TargetType="Button">
            <Setter Property="OverridesDefaultStyle" Value="True" />
            <Setter Property="Template">
                <Setter.Value>
                    <ControlTemplate TargetType="Button">
                        <Border Name="border" BorderThickness="0" BorderBrush="Black" Background="{TemplateBinding Background}">
                            <ContentPresenter HorizontalAlignment="Center" VerticalAlignment="Center" />
                        </Border>
                        <ControlTemplate.Triggers>
                            <Trigger Property="IsMouseOver" Value="True">
                                <Setter Property="Opacity" Value="0.8" />
                            </Trigger>
                        </ControlTemplate.Triggers>
                    </ControlTemplate>
                </Setter.Value>
            </Setter>
        </Style>
    </Window.Resources>
    <Grid Margin="10">
        <Image Source="https://camo.githubusercontent.com/4a3bc1dda5317541149f611a94cf0f068521ddd74630f3b9726d4e092be06d77/68747470733a2f2f696d616765732e706c696e672e636f6d2f696d672f30302f30302f36342f36362f30322f313730303531342f31312e706e67" HorizontalAlignment="Center" VerticalAlignment="Top" Width="50" Height="50" Margin="10,5,10,10"/>

        <ListBox Name="CommandList" Visibility="Visible" Height="210" SelectionMode="Multiple" Margin="10,70,10,10" HorizontalAlignment="Center" VerticalAlignment="Top" Width="510">
            <ListBox.Resources>
                <Style TargetType="Border">
                    <Setter Property="CornerRadius" Value="3"/>
                </Style>
            </ListBox.Resources>
            <ListBoxItem IsSelected="True">Clear Temporary Files</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Telemetry</ListBoxItem>
            <ListBoxItem IsSelected="True">Scan System Files</ListBoxItem>
            <ListBoxItem IsSelected="True">Clear DNS Cache</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Cortana</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Wi-Fi Sense</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable SmartScreen Filter</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Bing Search in Start Menu</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable App Suggestions</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Activity History</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Sensors</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Location Services</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Map Updates</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Feedback</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Tailored Experiences</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Advertising ID</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Website Access to Language List</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Biometric Services</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Access to Camera</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Access to Microphone</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Error reporting</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable UWP Apps Background Access</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Access to Voice Activation</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable UWP Apps Notifications</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Admin Prompt</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Windows Defender</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable File Blocking</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable Fast Startup</ListBoxItem>
            <ListBoxItem IsSelected="True">Disable OneDrive</ListBoxItem>
            <ListBoxItem IsSelected="True">Uninstall Useless Microsoft Apps</ListBoxItem>
            <ListBoxItem IsSelected="True">Uninstall Useless Third-Party Apps</ListBoxItem>
            <ListBox.ItemTemplate>
                <DataTemplate>
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="2*"/>
                            <ColumnDefinition Width="2*"/>
                        </Grid.ColumnDefinitions>
                        <TextBlock Text="{Binding}" VerticalAlignment="Center" Grid.Column="0"/>
                    </Grid>
                </DataTemplate>
            </ListBox.ItemTemplate>
            <ListBox.ItemContainerStyle>
                <Style TargetType="ListBoxItem">
                    <Style.Resources>
                        <Style TargetType="Border">
                            <Setter Property="CornerRadius" Value="2"/>
                        </Style>
                    </Style.Resources>
                    <Setter Property="Margin" Value="1,2,1,0"/>
                </Style>
            </ListBox.ItemContainerStyle>
        </ListBox>

        <ListBox Name="LogList" Visibility="Hidden" Height="210" SelectionMode="Multiple" Margin="10,70,10,10" HorizontalAlignment="Center" VerticalAlignment="Top" Width="510">
            <ListBox.Resources>
                <Style TargetType="Border">
                    <Setter Property="CornerRadius" Value="3"/>
                </Style>
            </ListBox.Resources>
            <ListBox.ItemTemplate>
                <DataTemplate>
                    <Grid>
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="2*"/>
                            <ColumnDefinition Width="2*"/>
                        </Grid.ColumnDefinitions>
                        <TextBlock Text="{Binding}" VerticalAlignment="Center" Grid.Column="0"/>
                    </Grid>
                </DataTemplate>
            </ListBox.ItemTemplate>
            <ListBox.ItemContainerStyle>
                <Style TargetType="ListBoxItem">
                    <Style.Resources>
                        <Style TargetType="Border">
                            <Setter Property="CornerRadius" Value="2"/>
                        </Style>
                    </Style.Resources>
                    <Setter Property="Margin" Value="1,2,1,0"/>
                </Style>
            </ListBox.ItemContainerStyle>
        </ListBox>

        <!-- Action Buttons -->
        <StackPanel Name="PreStart" Visibility="Visible" Orientation="Horizontal" HorizontalAlignment="Center" VerticalAlignment="Bottom" Margin="0,50,0,10">
            <Button Name="CloseAppButton" Content="CLOSE" Style="{StaticResource MyButton}" FontWeight="Medium" FontSize="16" BorderThickness="0" Background="#F4F4F4" Foreground="#0088FF" Width="140" Height="40">
			     <Button.Resources>
                    <Style TargetType="{x:Type Border}">
                        <Setter Property="CornerRadius" Value="5"/>
                    </Style>
                </Button.Resources>
			</Button>
            <StackPanel Orientation="Vertical" Margin="5,0,0,0">
                <Button Name="SelectAllButton" Content="Select All" Style="{StaticResource MyButton}" FontWeight="Medium" FontSize="10" BorderThickness="0" Background="#F4F4F4" Foreground="#0088FF" Width="100" Height="17.5">
			         <Button.Resources>
                        <Style TargetType="{x:Type Border}">
                            <Setter Property="CornerRadius" Value="3"/>
                        </Style>
                    </Button.Resources>
			    </Button>
                <Button Name="DeselectAllButton" Content="Deselect All" Style="{StaticResource MyButton}" FontWeight="Medium" FontSize="10" BorderThickness="0" Background="#F4F4F4" Foreground="#0088FF" Width="100" Height="17.5" Margin="0,5,0,0">
			         <Button.Resources>
                        <Style TargetType="{x:Type Border}">
                            <Setter Property="CornerRadius" Value="3"/>
                        </Style>
                    </Button.Resources>
			    </Button>
            </StackPanel>
            <Button Name="StartButton" Content="START" Style="{StaticResource MyButton}" FontWeight="Medium" FontSize="17" BorderThickness="0" Background="#0088FF" Foreground="White" Width="240" Height="40" Margin="30,0,0,0">
			     <Button.Resources>
                    <Style TargetType="{x:Type Border}">
                        <Setter Property="CornerRadius" Value="5"/>
                    </Style>
                </Button.Resources>
			</Button>
        </StackPanel>
        <StackPanel Name="PostStart" Visibility="Hidden" Orientation="Horizontal" HorizontalAlignment="Center" VerticalAlignment="Bottom" Margin="0,50,0,10">
            <Button Name="CloseAppButton2" Content="FINISH" Style="{StaticResource MyButton}" FontWeight="Medium" FontSize="17" BorderThickness="0" Background="#F4F4F4" Foreground="#0088FF" Width="510" Height="40">
			     <Button.Resources>
                    <Style TargetType="{x:Type Border}">
                        <Setter Property="CornerRadius" Value="5"/>
                    </Style>
                </Button.Resources>
			</Button>
        </StackPanel>
    </Grid>
</Window>
"@

# Load XAML
[xml]$xaml = $xaml

$reader = (New-Object System.Xml.XmlNodeReader $xaml)

try {
    $window = [Windows.Markup.XamlReader]::Load($reader)
}
catch {
    Write-Warning $_.Exception
    throw
}


$window.FindName("CloseAppButton").Add_Click({
    $window.Close()
})

$window.FindName("CloseAppButton2").Add_Click({
    $window.Close()
})

$window.FindName("SelectAllButton").Add_Click({
    $window.FindName("CommandList").SelectAll()
})

$window.FindName("DeselectAllButton").Add_Click({
    $window.FindName("CommandList").UnselectAll()
})

$window.FindName("StartButton").Add_Click({
    $window.FindName("CommandList").Visibility = "Hidden"
    $window.FindName("LogList").Visibility = "Visible"
    $window.FindName("PreStart").Visibility = "Hidden"
    $window.FindName("PostStart").Visibility = "Visible"
    $commandlist = $window.FindName("CommandList");
    $loglist = $window.FindName("LogList");
    $timer = [Diagnostics.Stopwatch]::StartNew()
    $errors = 0
    foreach ($command in $commandlist.SelectedItems) {
        $command = $command.Content
        try
        {
            if ($command -eq "Clear Temporary Files") {
                $loglist.Items.Add("Cleaning Temporary Files...") | Out-Null
                Remove-Item $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue
            }
            elseif ($command -eq "Disable Telemetry") {
                $loglist.Items.Add("Disabling Telemetry...") | Out-Null
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" -Name "AllowBuildPreview" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\CurrentVersion\Software Protection Platform" -Name "NoGenTicket" -Type DWord -Value 1
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\SQMClient\Windows" -Name "CEIPEnable" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "AITEnable" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat" -Name "DisableInventory" -Type DWord -Value 1
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\AppV\CEIP")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\AppV\CEIP" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\AppV\CEIP" -Name "CEIPEnable" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC" -Name "PreventHandwritingDataSharing" -Type DWord -Value 1
	            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput")) {
		            New-Item -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\TextInput" -Name "AllowLinguisticDataCollection" -Type DWord -Value 0
	            Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" | Out-Null
	            Disable-ScheduledTask -TaskName "Microsoft\Windows\Application Experience\ProgramDataUpdater" | Out-Null
	            Disable-ScheduledTask -TaskName "Microsoft\Windows\Autochk\Proxy" | Out-Null
	            Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" | Out-Null
	            Disable-ScheduledTask -TaskName "Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" | Out-Null
	            Disable-ScheduledTask -TaskName "Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" | Out-Null
	            # Office 2016 / 2019
	            Disable-ScheduledTask -TaskName "Microsoft\Office\Office ClickToRun Service Monitor" -ErrorAction SilentlyContinue | Out-Null
	            Disable-ScheduledTask -TaskName "Microsoft\Office\OfficeTelemetryAgentFallBack2016" -ErrorAction SilentlyContinue | Out-Null
	            Disable-ScheduledTask -TaskName "Microsoft\Office\OfficeTelemetryAgentLogOn2016" -ErrorAction SilentlyContinue | Out-Null
            }
            elseif ($command -eq "Scan System Files") {
                $loglist.Items.Add("Scanning System Files...") | Out-Null
                $newProcess = new-object System.Diagnostics.ProcessStartInfo "cmd";
                $newProcess.Arguments = "/c title Scanning System Files & sfc /scannow";
                $newProcess.Verb = "runas";
                $process = [System.Diagnostics.Process]::Start($newProcess);
                $process.WaitForExit()
            }
            elseif ($command -eq "Clear DNS Cache") {
                $loglist.Items.Add("Clearing DNS Cache...") | Out-Null
                ipconfig /flushdns
            }
            elseif ($command -eq "Disable Cortana") {
                $loglist.Items.Add("Disabling Cortana...") | Out-Null
                If (!(Test-Path "HKCU:\Software\Microsoft\Personalization\Settings")) {
		            New-Item -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Personalization\Settings" -Name "AcceptedPrivacyPolicy" -Type DWord -Value 0
	            If (!(Test-Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore")) {
		            New-Item -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitTextCollection" -Type DWord -Value 1
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization" -Name "RestrictImplicitInkCollection" -Type DWord -Value 1
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\InputPersonalization\TrainedDataStore" -Name "HarvestContacts" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowCortanaButton" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" -Name "Value" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\InputPersonalization" -Name "AllowInputPersonalization" -Type DWord -Value 0
	            Get-AppxPackage "Microsoft.549981C3F5F10" | Remove-AppxPackage
            }
            elseif ($command -eq "Disable Wi-Fi Sense") {
                $loglist.Items.Add("Disabling Wi-Fi Sense...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
		            New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots")) {
		            New-Item -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config")) {
		            New-Item -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "AutoConnectAllowedOEM" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" -Name "WiFISenseAllowed" -Type DWord -Value 0
            }
            elseif ($command -eq "Disable SmartScreen Filter") {
                $loglist.Items.Add("Disabling SmartScreen Filter...") | Out-Null
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableSmartScreen" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter" -Name "EnabledV9" -Type DWord -Value 0
            }
            elseif ($command -eq "Disable Bing Search in Start Menu") {
                $loglist.Items.Add("Disabling Bing Search in Start Menu...") | Out-Null
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "CortanaConsent" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "DisableWebSearch" -Type DWord -Value 1
            }
            elseif ($command -eq "Disable App Suggestions") {
                $loglist.Items.Add("Disabling App Suggestions...") | Out-Null
                Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-310093Enabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-314559Enabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338393Enabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353694Enabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353696Enabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type DWord -Value 0
	            If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement")) {
		            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\UserProfileEngagement" -Name "ScoobeSystemSettingEnabled" -Type DWord -Value 0
	            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\WindowsInkWorkspace" -Name "AllowSuggestedAppsInWindowsInkWorkspace" -Type DWord -Value 0
	            If ([System.Environment]::OSVersion.Version.Build -ge 17134) {
		            $key = Get-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\CloudStore\Store\Cache\DefaultAccount\*windows.data.placeholdertilecollection\Current"
		            Set-ItemProperty -Path $key.PSPath -Name "Data" -Type Binary -Value $key.Data[0..15]
		            Stop-Process -Name "ShellExperienceHost" -Force -ErrorAction SilentlyContinue
	            }
            }
            elseif ($command -eq "Disable Activity History") {
                $loglist.Items.Add("Disabling Activity History...") | Out-Null
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "EnableActivityFeed" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "PublishUserActivities" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System" -Name "UploadUserActivities" -Type DWord -Value 0
            }
            elseif ($command -eq "Disable Sensors") {
                $loglist.Items.Add("Disabling Sensors...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableSensors" -Type DWord -Value 1
            }
            elseif ($command -eq "Disable Location Services") {
                $loglist.Items.Add("Disabling Location Services...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocation" -Type DWord -Value 1
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" -Name "DisableLocationScripting" -Type DWord -Value 1
            }
            elseif ($command -eq "Disable Map Updates") {
                $loglist.Items.Add("Disabling Map Updates...") | Out-Null
                Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Type DWord -Value 0
            }
            elseif ($command -eq "Disable Feedback") {
                $loglist.Items.Add("Disabling Feedback...") | Out-Null
                If (!(Test-Path "HKCU:\Software\Microsoft\Siuf\Rules")) {
		            New-Item -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Siuf\Rules" -Name "NumberOfSIUFInPeriod" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "DoNotShowFeedbackNotifications" -Type DWord -Value 1
	            Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClient" -ErrorAction SilentlyContinue | Out-Null
	            Disable-ScheduledTask -TaskName "Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload" -ErrorAction SilentlyContinue | Out-Null
            }
            elseif ($command -eq "Disable Tailored Experiences") {
                $loglist.Items.Add("Disabling Tailored Experiences...") | Out-Null
                If (!(Test-Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent")) {
		            New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\CloudContent" -Name "DisableTailoredExperiencesWithDiagnosticData" -Type DWord -Value 1
            }
            elseif ($command -eq "Disable Advertising ID") {
                $loglist.Items.Add("Disabling Advertising ID...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" -Name "DisabledByGroupPolicy" -Type DWord -Value 1
            }
            elseif ($command -eq "Disable Website Access to Language List") {
                $loglist.Items.Add("Disabling Website Access to Language List...") | Out-Null
                Set-ItemProperty -Path "HKCU:\Control Panel\International\User Profile" -Name "HttpAcceptLanguageOptOut" -Type DWord -Value 1
            }
            elseif ($command -eq "Disable Biometric Services") {
                $loglist.Items.Add("Disabling Biometric Services...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Biometrics" -Name "Enabled" -Type DWord -Value 0
            }
            elseif ($command -eq "Disable Access to Camera") {
                $loglist.Items.Add("Disabling Access to Camera...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessCamera" -Type DWord -Value 2
            }
            elseif ($command -eq "Disable Access to Microphone") {
                $loglist.Items.Add("Disabling Access to Microphone...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessMicrophone" -Type DWord -Value 2
            }
            elseif ($command -eq "Disable Error reporting") {
                $loglist.Items.Add("Disabling Error reporting...") | Out-Null
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Type DWord -Value 1
	            Disable-ScheduledTask -TaskName "Microsoft\Windows\Windows Error Reporting\QueueReporting" | Out-Null
            }
            elseif ($command -eq "Disable UWP Apps Background Access") {
                $loglist.Items.Add("Disabling UWP Apps Background Access...") | Out-Null
                If ([System.Environment]::OSVersion.Version.Build -ge 17763) {
		            If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
			            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
		            }
		            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsRunInBackground" -Type DWord -Value 2
	            } Else {
		            Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" -Exclude "Microsoft.Windows.Cortana*", "Microsoft.Windows.ShellExperienceHost*" | ForEach-Object {
			            Set-ItemProperty -Path $_.PsPath -Name "Disabled" -Type DWord -Value 1
			            Set-ItemProperty -Path $_.PsPath -Name "DisabledByUser" -Type DWord -Value 1
		            }
	            }
            }
            elseif ($command -eq "Disable Access to Voice Activation") {
                $loglist.Items.Add("Disabling Access to Voice Activation...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoice" -Type DWord -Value 2
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsActivateWithVoiceAboveLock" -Type DWord -Value 2
            }
            elseif ($command -eq "Disable UWP Apps Notifications") {
                $loglist.Items.Add("Disabling UWP Apps Notifications...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" -Name "LetAppsAccessNotifications" -Type DWord -Value 2
            }
            elseif ($command -eq "Disable Admin Prompt") {
                $loglist.Items.Add("Disabling Admin Prompt...") | Out-Null
                Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "PromptOnSecureDesktop" -Type DWord -Value 0
            }
            elseif ($command -eq "Disable Windows Defender") {
                $loglist.Items.Add("Disabling Windows Defender...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Force | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Type DWord -Value 1
	            If ([System.Environment]::OSVersion.Version.Build -eq 14393) {
		            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "WindowsDefender" -ErrorAction SilentlyContinue
	            } ElseIf ([System.Environment]::OSVersion.Version.Build -ge 15063) {
		            Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" -Name "SecurityHealth" -ErrorAction SilentlyContinue
	            }
            }
            elseif ($command -eq "Disable File Blocking") {
                $loglist.Items.Add("Disabling File Blocking...") | Out-Null
                If (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments")) {
		            New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" | Out-Null
	            }
	            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Type DWord -Value 1
            }
            elseif ($command -eq "Disable Fast Startup") {
                $loglist.Items.Add("Disabling Fast Startup...") | Out-Null
                Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power" -Name "HiberbootEnabled" -Type DWord -Value 0
            }
            elseif ($command -eq "Disable OneDrive") {
                $loglist.Items.Add("Disabling OneDrive...") | Out-Null
                If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive")) {
		            New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" | Out-Null
	            }
	            Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\OneDrive" -Name "DisableFileSyncNGSC" -Type DWord -Value 1
            }
            elseif ($command -eq "Uninstall Useless Microsoft Apps") {
                $loglist.Items.Add("Uninstalling Useless Microsoft Applications...") | Out-Null
                Get-AppxPackage "Microsoft.3DBuilder" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.AppConnector" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.BingFinance" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.BingFoodAndDrink" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.BingHealthAndFitness" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.BingMaps" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.BingNews" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.BingSports" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.BingTranslator" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.BingTravel" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.BingWeather" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.CommsPhone" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.ConnectivityStore" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.FreshPaint" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.GetHelp" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Getstarted" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.HelpAndTips" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Media.PlayReadyClient.2" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Messaging" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Microsoft3DViewer" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.MicrosoftOfficeHub" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.MicrosoftPowerBIForWindows" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.MicrosoftSolitaireCollection" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.MicrosoftStickyNotes" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.MinecraftUWP" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.MixedReality.Portal" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.MoCamera" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.MSPaint" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.NetworkSpeedTest" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.OfficeLens" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Office.OneNote" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Office.Sway" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.OneConnect" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.People" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Print3D" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Reader" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.RemoteDesktop" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.SkypeApp" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Todos" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Wallet" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WebMediaExtensions" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Whiteboard" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WindowsAlarms" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WindowsCamera" | Remove-AppxPackage
	            Get-AppxPackage "microsoft.windowscommunicationsapps" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WindowsFeedbackHub" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WindowsMaps" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WindowsPhone" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Windows.Photos" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WindowsReadingList" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WindowsScan" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WindowsSoundRecorder" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WinJS.1.0" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.WinJS.2.0" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.YourPhone" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.ZuneMusic" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.ZuneVideo" | Remove-AppxPackage
	            Get-AppxPackage "Microsoft.Advertising.Xaml" | Remove-AppxPackage
            }
            elseif ($command -eq "Uninstall Useless Third-Party Apps") {
                $loglist.Items.Add("Uninstalling Useless Third-Party Apps...") | Out-Null
                Get-AppxPackage "2414FC7A.Viber" | Remove-AppxPackage
	            Get-AppxPackage "41038Axilesoft.ACGMediaPlayer" | Remove-AppxPackage
	            Get-AppxPackage "46928bounde.EclipseManager" | Remove-AppxPackage
	            Get-AppxPackage "4DF9E0F8.Netflix" | Remove-AppxPackage
	            Get-AppxPackage "64885BlueEdge.OneCalendar" | Remove-AppxPackage
	            Get-AppxPackage "7EE7776C.LinkedInforWindows" | Remove-AppxPackage
	            Get-AppxPackage "828B5831.HiddenCityMysteryofShadows" | Remove-AppxPackage
	            Get-AppxPackage "89006A2E.AutodeskSketchBook" | Remove-AppxPackage
	            Get-AppxPackage "9E2F88E3.Twitter" | Remove-AppxPackage
	            Get-AppxPackage "A278AB0D.DisneyMagicKingdoms" | Remove-AppxPackage
	            Get-AppxPackage "A278AB0D.DragonManiaLegends" | Remove-AppxPackage
	            Get-AppxPackage "A278AB0D.MarchofEmpires" | Remove-AppxPackage
	            Get-AppxPackage "ActiproSoftwareLLC.562882FEEB491" | Remove-AppxPackage
	            Get-AppxPackage "AD2F1837.GettingStartedwithWindows8" | Remove-AppxPackage
	            Get-AppxPackage "AD2F1837.HPJumpStart" | Remove-AppxPackage
	            Get-AppxPackage "AD2F1837.HPRegistration" | Remove-AppxPackage
	            Get-AppxPackage "AdobeSystemsIncorporated.AdobePhotoshopExpress" | Remove-AppxPackage
	            Get-AppxPackage "Amazon.com.Amazon" | Remove-AppxPackage
	            Get-AppxPackage "C27EB4BA.DropboxOEM" | Remove-AppxPackage
	            Get-AppxPackage "CAF9E577.Plex" | Remove-AppxPackage
	            Get-AppxPackage "CyberLinkCorp.hs.PowerMediaPlayer14forHPConsumerPC" | Remove-AppxPackage
	            Get-AppxPackage "D52A8D61.FarmVille2CountryEscape" | Remove-AppxPackage
	            Get-AppxPackage "D5EA27B7.Duolingo-LearnLanguagesforFree" | Remove-AppxPackage
	            Get-AppxPackage "DB6EA5DB.CyberLinkMediaSuiteEssentials" | Remove-AppxPackage
	            Get-AppxPackage "DolbyLaboratories.DolbyAccess" | Remove-AppxPackage
	            Get-AppxPackage "Drawboard.DrawboardPDF" | Remove-AppxPackage
	            Get-AppxPackage "Facebook.Facebook" | Remove-AppxPackage
	            Get-AppxPackage "Fitbit.FitbitCoach" | Remove-AppxPackage
	            Get-AppxPackage "flaregamesGmbH.RoyalRevolt2" | Remove-AppxPackage
	            Get-AppxPackage "GAMELOFTSA.Asphalt8Airborne" | Remove-AppxPackage
	            Get-AppxPackage "KeeperSecurityInc.Keeper" | Remove-AppxPackage
	            Get-AppxPackage "king.com.BubbleWitch3Saga" | Remove-AppxPackage
	            Get-AppxPackage "king.com.CandyCrushFriends" | Remove-AppxPackage
	            Get-AppxPackage "king.com.CandyCrushSaga" | Remove-AppxPackage
	            Get-AppxPackage "king.com.CandyCrushSodaSaga" | Remove-AppxPackage
	            Get-AppxPackage "king.com.FarmHeroesSaga" | Remove-AppxPackage
	            Get-AppxPackage "Nordcurrent.CookingFever" | Remove-AppxPackage
	            Get-AppxPackage "PandoraMediaInc.29680B314EFC2" | Remove-AppxPackage
	            Get-AppxPackage "PricelinePartnerNetwork.Booking.comBigsavingsonhot" | Remove-AppxPackage
	            Get-AppxPackage "SpotifyAB.SpotifyMusic" | Remove-AppxPackage
	            Get-AppxPackage "ThumbmunkeysLtd.PhototasticCollage" | Remove-AppxPackage
	            Get-AppxPackage "WinZipComputing.WinZipUniversal" | Remove-AppxPackage
	            Get-AppxPackage "XINGAG.XING" | Remove-AppxPackage
            }
        }
        catch { $errors++ }
    }
    $timer.stop() 
    $elapsedTimeMinutes = $timer.Elapsed.TotalMinutes
    $window.FindName("LogList").Items.Add("Finished. Errors: " + $errors + ", Time Elapsed: $($elapsedTimeMinutes.ToString("F2")) minutes.") | Out-Null
})

# Show the window
$window.ShowDialog() | Out-Null