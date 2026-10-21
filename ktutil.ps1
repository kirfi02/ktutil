# ====================================================================
#               KIRFI TECH SYSTEM UTILITY (KTUTIL) v1.0
#     Maintainer: Ukasha M. I. Kirfi | IoT & AI Systems Developer
# ====================================================================

Clear-Host

# 1. Verified KIRFI TECH Terminal Banner (Open-C Design)
$KirfiBanner = @"
██╗  ██╗██╗██████╗ ███████╗██╗    ████████╗███████╗██████╗ ██╗  ██╗
██║ ██╔╝██║██╔══██╗██╔════╝██║    ╚══██╔══╝██╔════╝██╔═══╝ ██║  ██║
█████╔╝ ██║██████╔╝█████╗  ██║       ██║   █████╗  ██║     ███████║
██╔═██╗ ██║██╔══██╗██╔══╝  ██║       ██║   ██╔══╝  ██║     ██╔══██║
██║  ██╗██║██║  ██║██║     ██║       ██║   ███████╗╚██████╗██║  ██║
╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚═╝     ╚═╝       ╚═╝   ╚══════╝ ╚═════╝╚═╝  ╚═╝
"@

Write-Host $KirfiBanner -ForegroundColor Cyan
Write-Host "==========================================================================" -ForegroundColor DarkGray
Write-Host "                KIRFI TECH SYSTEM UTILITY (KTUTIL) v1.0                   " -ForegroundColor Green
Write-Host "    Maintainer: Ukasha M. I. Kirfi | Windows Debloat, AI & IoT Engine     " -ForegroundColor Yellow
Write-Host "==========================================================================" -ForegroundColor DarkGray

# 2. Heuristic Real-time Logging Function
function Write-KTLog {
    param (
        [string]$Level = "INFO",
        [string]$Module = "CORE",
        [string]$Message
    )
    $TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss.fff"
    $Color = switch ($Level) {
        "INFO"    { "Gray" }
        "WARN"    { "Yellow" }
        "ERROR"   { "Red" }
        "SUCCESS" { "Green" }
        Default   { "White" }
    }
    Write-Host "[$TimeStamp] [$Level] [$Module] $Message" -ForegroundColor $Color
}

# 3. System Heuristic Diagnostics
Write-KTLog -Level "INFO" -Module "INIT" -Message "Initializing Kirfi Tech Engine..."

$IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $IsAdmin) {
    Write-KTLog -Level "WARN" -Module "SECURITY" -Message "Process running un-elevated! Run PowerShell as Administrator for full registry/service tweaks."
} else {
    Write-KTLog -Level "SUCCESS" -Module "SECURITY" -Message "Administrator privileges confirmed."
}

$OSBuild = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").CurrentBuild
$CPU = (Get-CimInstance Win32_Processor).Name.Trim()
Write-KTLog -Level "INFO" -Module "HEURISTIC" -Message "Host OS: Windows Build $OSBuild"
Write-KTLog -Level "INFO" -Module "HEURISTIC" -Message "Processor: $CPU"

# 4. Core Execution Helper Functions
function Install-KTWingetApp {
    param ([string]$AppName, [string]$AppId)
    Write-KTLog -Level "INFO" -Module "WINGET" -Message "Installing $AppName [$AppId]..."
    try {
        $process = Start-Process -FilePath "winget" -ArgumentList "install --id $AppId -e --silent --accept-package-agreements --accept-source-agreements" -NoNewWindow -Wait -PassThru
        if ($process.ExitCode -eq 0) {
            Write-KTLog -Level "SUCCESS" -Module "WINGET" -Message "Successfully installed $AppName."
        } else {
            Write-KTLog -Level "WARN" -Module "WINGET" -Message "$AppName returned exit code: $($process.ExitCode) (may already be installed)."
        }
    } catch {
        Write-KTLog -Level "ERROR" -Module "WINGET" -Message "Failed to install $AppName: $_"
    }
}

function Apply-KTRegistryTweak {
    param ([string]$TweakName, [string]$Path, [string]$Property, [string]$Type, $Value)
    Write-KTLog -Level "INFO" -Module "REGISTRY" -Message "Applying Tweak: $TweakName"
    try {
        if (-not (Test-Path $Path)) {
            New-Item -Path $Path -Force | Out-Null
        }
        New-ItemProperty -Path $Path -Name $Property -PropertyType $Type -Value $Value -Force | Out-Null
        Write-KTLog -Level "SUCCESS" -Module "REGISTRY" -Message "Applied: $TweakName"
    } catch {
        Write-KTLog -Level "ERROR" -Module "REGISTRY" -Message "Failed $TweakName: $_"
    }
}

function Configure-KTService {
    param ([string]$ServiceName, [string]$StartupType)
    Write-KTLog -Level "INFO" -Module "SERVICE" -Message "Configuring service '$ServiceName' -> $StartupType"
    try {
        Set-Service -Name $ServiceName -StartupType $StartupType -ErrorAction Stop
        Write-KTLog -Level "SUCCESS" -Module "SERVICE" -Message "Service '$ServiceName' configured."
    } catch {
        Write-KTLog -Level "WARN" -Module "SERVICE" -Message "Unable to configure service '$ServiceName': $_"
    }
}

# 5. Load WPF Framework & Render UI
Write-KTLog -Level "INFO" -Module "UI" -Message "Starting WPF Interface Thread..."
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="KIRFI TECH SYSTEM UTILITY (KTUTIL)" Height="620" Width="880"
        Background="#0D1117" WindowStartupLocation="CenterScreen">
    <Window.Resources>
        <Style TargetType="TabItem">
            <Setter Property="HeaderTemplate">
                <Setter.Value>
                    <DataTemplate>
                        <ContentPresenter Content="{TemplateBinding Content}" Margin="10,5"/>
                    </DataTemplate>
                </Setter.Value>
            </Setter>
            <Setter Property="Background" Value="#161B22"/>
            <Setter Property="Foreground" Value="#8B949E"/>
            <Setter Property="FontSize" Value="13"/>
            <Setter Property="FontWeight" Value="SemiBold"/>
        </Style>
        <Style TargetType="CheckBox">
            <Setter Property="Foreground" Value="#C9D1D9"/>
            <Setter Property="Margin" Value="5,4"/>
            <Setter Property="FontSize" Value="12"/>
        </Style>
        <Style TargetType="Button">
            <Setter Property="Background" Value="#21262D"/>
            <Setter Property="Foreground" Value="#58A6FF"/>
            <Setter Property="BorderBrush" Value="#30363D"/>
            <Setter Property="BorderThickness" Value="1"/>
            <Setter Property="Padding" Value="10,6"/>
            <Setter Property="FontWeight" Value="Bold"/>
            <Setter Property="Cursor" Value="Hand"/>
        </Style>
    </Window.Resources>

    <Grid Margin="15">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Header Banner -->
        <Border Grid.Row="0" Background="#161B22" CornerRadius="6" Padding="15" Margin="0,0,0,12" BorderBrush="#30363D" BorderThickness="1">
            <DockPanel>
                <StackPanel DockPanel.Dock="Left">
                    <TextBlock Text="KIRFI TECH UTILITY" Foreground="#58A6FF" FontSize="18" FontWeight="Bold"/>
                    <TextBlock Text="Windows Debloat • CTT Parity • Local AI &amp; IoT Engine" Foreground="#8B949E" FontSize="11"/>
                </StackPanel>
                <TextBlock DockPanel.Dock="Right" Text="v1.0" Foreground="#3FB950" FontSize="16" FontWeight="Bold" VerticalAlignment="Center" HorizontalAlignment="Right"/>
            </DockPanel>
        </Border>

        <!-- Main Tab Control -->
        <TabControl Grid.Row="1" Background="#0D1117" BorderBrush="#30363D">
            
            <!-- TAB 1: INSTALL APPS -->
            <TabItem Header="Install Apps">
                <Grid Margin="10">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Grid.Column="0">
                        <TextBlock Text="Browsers &amp; Comms" Foreground="#58A6FF" FontWeight="Bold" Margin="5"/>
                        <CheckBox Name="chkChrome" Content="Google Chrome"/>
                        <CheckBox Name="chkFirefox" Content="Mozilla Firefox"/>
                        <CheckBox Name="chkBrave" Content="Brave Browser"/>
                        <CheckBox Name="chkDiscord" Content="Discord"/>
                    </StackPanel>
                    <StackPanel Grid.Column="1">
                        <TextBlock Text="Utilities &amp; Tools" Foreground="#58A6FF" FontWeight="Bold" Margin="5"/>
                        <CheckBox Name="chk7Zip" Content="7-Zip"/>
                        <CheckBox Name="chkVLC" Content="VLC Media Player"/>
                        <CheckBox Name="chkNotepadPP" Content="Notepad++"/>
                        <CheckBox Name="chkPowerToys" Content="Microsoft PowerToys"/>
                    </StackPanel>
                    <StackPanel Grid.Column="2">
                        <TextBlock Text="Dev Environment" Foreground="#58A6FF" FontWeight="Bold" Margin="5"/>
                        <CheckBox Name="chkVSCode" Content="VS Code"/>
                        <CheckBox Name="chkGit" Content="Git for Windows"/>
                        <CheckBox Name="chkPython" Content="Python 3.11"/>
                        <CheckBox Name="chkTerminal" Content="Windows Terminal"/>
                    </StackPanel>
                </Grid>
            </TabItem>

            <!-- TAB 2: SYSTEM TWEAKS -->
            <TabItem Header="Tweaks">
                <Grid Margin="10">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Grid.Column="0">
                        <TextBlock Text="Debloat &amp; Privacy" Foreground="#58A6FF" FontWeight="Bold" Margin="5"/>
                        <CheckBox Name="chkTelemetry" Content="Disable Telemetry &amp; DiagTrack" IsChecked="True"/>
                        <CheckBox Name="chkCortana" Content="Disable Cortana &amp; Web Search" IsChecked="True"/>
                        <CheckBox Name="chkCopilot" Content="Disable Windows Copilot" IsChecked="True"/>
                        <CheckBox Name="chkGameBar" Content="Disable Xbox Game Bar &amp; DVR"/>
                    </StackPanel>
                    <StackPanel Grid.Column="1">
                        <TextBlock Text="Performance Tweaks" Foreground="#58A6FF" FontWeight="Bold" Margin="5"/>
                        <CheckBox Name="chkSysMain" Content="Disable SysMain (Superfetch)" IsChecked="True"/>
                        <CheckBox Name="chkPowerPlan" Content="Set Ultimate Performance Power Plan"/>
                        <CheckBox Name="chkHibernate" Content="Disable Hibernation (Reclaim Space)"/>
                    </StackPanel>
                </Grid>
            </TabItem>

            <!-- TAB 3: CONFIG & REPAIR -->
            <TabItem Header="Config &amp; Fixes">
                <StackPanel Margin="10">
                    <TextBlock Text="System Repair &amp; Tools" Foreground="#58A6FF" FontWeight="Bold" Margin="5"/>
                    <WrapPanel Margin="0,10">
                        <Button Name="btnSFC" Content="Run SFC System Repair" Margin="5"/>
                        <Button Name="btnNetworkReset" Content="Reset Network Stack" Margin="5"/>
                        <Button Name="btnControlPanel" Content="Open Legacy Control Panel" Margin="5"/>
                        <Button Name="btnDNS" Content="Flush DNS Cache" Margin="5"/>
                    </WrapPanel>
                </StackPanel>
            </TabItem>

            <!-- TAB 4: WINDOWS UPDATES -->
            <TabItem Header="Updates">
                <StackPanel Margin="15">
                    <TextBlock Text="Windows Update Management Profile" Foreground="#58A6FF" FontWeight="Bold" Margin="0,0,0,10"/>
                    <RadioButton Name="radUpdateDefault" Content="Default Windows Update Settings" Foreground="#C9D1D9" Margin="5" IsChecked="True"/>
                    <RadioButton Name="radUpdateSecurity" Content="Security-Only Mode (Defer Features 1 Year)" Foreground="#C9D1D9" Margin="5"/>
                    <RadioButton Name="radUpdatePause" Content="Pause Windows Updates Completely" Foreground="#C9D1D9" Margin="5"/>
                </StackPanel>
            </TabItem>

            <!-- TAB 5: BEYOND LAYER (AI & IOT ENGINE) -->
            <TabItem Header="🚀 Kirfi AI &amp; Hardware">
                <Grid Margin="10">
                    <Grid.ColumnDefinitions>
                        <ColumnDefinition Width="*"/>
                        <ColumnDefinition Width="*"/>
                    </Grid.ColumnDefinitions>
                    <StackPanel Grid.Column="0">
                        <TextBlock Text="Local AI Engine Stack" Foreground="#A371F7" FontWeight="Bold" Margin="5"/>
                        <CheckBox Name="chkOllama" Content="Install Ollama Background Service" IsChecked="True"/>
                        <CheckBox Name="chkDeepSeek" Content="Auto-Pull DeepSeek-R1 (8B Model)" IsChecked="True"/>
                        <CheckBox Name="chkDocker" Content="Install Docker Desktop"/>
                    </StackPanel>
                    <StackPanel Grid.Column="1">
                        <TextBlock Text="IoT &amp; Hardware Dev Suite" Foreground="#3FB950" FontWeight="Bold" Margin="5"/>
                        <CheckBox Name="chkArduino" Content="Arduino IDE 2.x" IsChecked="True"/>
                        <CheckBox Name="chkPuTTY" Content="PuTTY Serial Client"/>
                        <CheckBox Name="chkSerialDrivers" Content="CH340 &amp; CP210x USB-Serial Drivers" IsChecked="True"/>
                    </StackPanel>
                </Grid>
            </TabItem>

        </TabControl>

        <!-- Footer Execution Control -->
        <DockPanel Grid.Row="2" Margin="0,12,0,0">
            <TextBlock Name="txtStatus" Text="Status: Engine Ready. Select options and click RUN." Foreground="#8B949E" VerticalAlignment="Center" DockPanel.Dock="Left"/>
            <Button Name="btnRun" Content="RUN SELECTIONS" Background="#238636" Foreground="White" Width="160" HorizontalAlignment="Right" DockPanel.Dock="Right"/>
        </DockPanel>
    </Grid>
</Window>
"@

# Render GUI Window
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

# Map UI Controls
$btnRun = $window.FindName("btnRun")
$txtStatus = $window.FindName("txtStatus")

# Quick Button Handlers
$window.FindName("btnSFC").Add_Click({
    Write-KTLog -Level "INFO" -Module "REPAIR" -Message "Running System File Checker (sfc /scannow)..."
    Start-Process "cmd.exe" -ArgumentList "/c sfc /scannow" -Verb RunAs
})
$window.FindName("btnNetworkReset").Add_Click({
    Write-KTLog -Level "INFO" -Module "REPAIR" -Message "Resetting Winsock & IP Stack..."
    netsh winsock reset | Out-Null
    netsh int ip reset | Out-Null
    Write-KTLog -Level "SUCCESS" -Module "REPAIR" -Message "Network stack reset completed."
})
$window.FindName("btnControlPanel").Add_Click({
    Start-Process "control.exe"
})
$window.FindName("btnDNS").Add_Click({
    ipconfig /flushdns | Out-Null
    Write-KTLog -Level "SUCCESS" -Module "REPAIR" -Message "DNS cache flushed."
})

# Master Run Execution Listener
$btnRun.Add_Click({
    $txtStatus.Text = "Status: Executing Selections..."
    Write-KTLog -Level "INFO" -Module "EXEC" -Message "================ STARTING EXECUTION ENGINE ================"
    
    # --- 1. APPLICATION INSTALLATIONS ---
    $AppMap = @{
        "chkChrome"        = @{ Name = "Google Chrome"; ID = "Google.Chrome" }
        "chkFirefox"       = @{ Name = "Mozilla Firefox"; ID = "Mozilla.Firefox" }
        "chkBrave"         = @{ Name = "Brave Browser"; ID = "Brave.Brave" }
        "chkDiscord"       = @{ Name = "Discord"; ID = "Discord.Discord" }
        "chk7Zip"          = @{ Name = "7-Zip"; ID = "7zip.7zip" }
        "chkVLC"           = @{ Name = "VLC Media Player"; ID = "VideoLAN.VLC" }
        "chkNotepadPP"     = @{ Name = "Notepad++"; ID = "Notepad++.Notepad++" }
        "chkPowerToys"     = @{ Name = "Microsoft PowerToys"; ID = "Microsoft.PowerToys" }
        "chkVSCode"        = @{ Name = "VS Code"; ID = "Microsoft.VisualStudioCode" }
        "chkGit"           = @{ Name = "Git for Windows"; ID = "Git.Git" }
        "chkPython"        = @{ Name = "Python 3.11"; ID = "Python.Python.3.11" }
        "chkTerminal"      = @{ Name = "Windows Terminal"; ID = "Microsoft.WindowsTerminal" }
        "chkOllama"        = @{ Name = "Ollama AI Engine"; ID = "Ollama.Ollama" }
        "chkDocker"        = @{ Name = "Docker Desktop"; ID = "Docker.DockerDesktop" }
        "chkArduino"       = @{ Name = "Arduino IDE"; ID = "Arduino.IDE.2" }
        "chkPuTTY"         = @{ Name = "PuTTY"; ID = "PuTTY.PuTTY" }
        "chkSerialDrivers" = @{ Name = "CH340 Serial Driver"; ID = "WCH.CH340" }
    }

    foreach ($chkName in $AppMap.Keys) {
        $control = $window.FindName($chkName)
        if ($control -and $control.IsChecked) {
            Install-KTWingetApp -AppName $AppMap[$chkName].Name -AppId $AppMap[$chkName].ID
        }
    }

    # --- 2. REGISTRY & DEBLOAT TWEAKS ---
    if ($window.FindName("chkTelemetry").IsChecked) {
        Apply-KTRegistryTweak -TweakName "Disable Telemetry" -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Property "AllowTelemetry" -Type "DWord" -Value 0
    }
    if ($window.FindName("chkCortana").IsChecked) {
        Apply-KTRegistryTweak -TweakName "Disable Cortana Web Search" -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Property "DisableWebSearch" -Type "DWord" -Value 1
    }
    if ($window.FindName("chkCopilot").IsChecked) {
        Apply-KTRegistryTweak -TweakName "Disable Windows Copilot" -Path "HKCU:\Software\Policies\Microsoft\Windows\WindowsCopilot" -Property "TurnOffWindowsCopilot" -Type "DWord" -Value 1
    }
    if ($window.FindName("chkGameBar").IsChecked) {
        Apply-KTRegistryTweak -TweakName "Disable Game Bar DVR" -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR" -Property "AppCaptureEnabled" -Type "DWord" -Value 0
    }

    # --- 3. PERFORMANCE SERVICES & POWER ---
    if ($window.FindName("chkSysMain").IsChecked) {
        Configure-KTService -ServiceName "SysMain" -StartupType "Disabled"
    }
    if ($window.FindName("chkPowerPlan").IsChecked) {
        Write-KTLog -Level "INFO" -Module "POWER" -Message "Setting Ultimate Performance Power Plan..."
        powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c 2>$null
    }
    if ($window.FindName("chkHibernate").IsChecked) {
        Write-KTLog -Level "INFO" -Module "POWER" -Message "Disabling System Hibernation..."
        powercfg /hibernate off 2>$null
    }

    # --- 4. KIRFI BEYOND LAYER (AI PROVISIONING) ---
    if ($window.FindName("chkDeepSeek").IsChecked) {
        Write-KTLog -Level "INFO" -Module "AI_ENGINE" -Message "Provisioning DeepSeek-R1 (8B Reasoning Model)..."
        if (Get-Command "ollama" -ErrorAction SilentlyContinue) {
            Start-Process "ollama" -ArgumentList "pull deepseek-r1:8b" -NoNewWindow -Wait
            Write-KTLog -Level "SUCCESS" -Module "AI_ENGINE" -Message "DeepSeek-R1 model active."
        } else {
            Write-KTLog -Level "WARN" -Module "AI_ENGINE" -Message "Ollama runtime not detected. Skipping model pull."
        }
    }

    $txtStatus.Text = "Status: All Actions Completed!"
    Write-KTLog -Level "SUCCESS" -Module "EXEC" -Message "================ EXECUTION COMPLETED CLEANLY ================"
})

$window.ShowDialog() | Out-Null
