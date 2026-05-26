<#
Project: IT System Health Check Tool
File: system-health-check.ps1
Purpose: Collect basic Windows system health information for IT support troubleshooting.

Author: Abdullah Khan
#>

$ReportFolder = ".\reports"

if (!(Test-Path $ReportFolder)) {
    New-Item -ItemType Directory -Path $ReportFolder | Out-Null
}

$TxtReport = "$ReportFolder\system-health-report.txt"
$CsvReport = "$ReportFolder\system-health-report.csv"
$HtmlReport = "$ReportFolder\system-health-report.html"

$ComputerName = $env:COMPUTERNAME
$LoggedInUser = $env:USERNAME
$CurrentDate = Get-Date

$OperatingSystem = Get-CimInstance Win32_OperatingSystem
$WindowsVersion = $OperatingSystem.Caption
$WindowsBuild = $OperatingSystem.BuildNumber

$LastBootTime = $OperatingSystem.LastBootUpTime
$Uptime = (Get-Date) - $LastBootTime
$UptimeDays = [math]::Round($Uptime.TotalDays, 1)

$Processor = Get-CimInstance Win32_Processor
$CpuName = $Processor.Name
$CpuCores = $Processor.NumberOfCores
$CpuLogicalProcessors = $Processor.NumberOfLogicalProcessors

$TotalRamBytes = $OperatingSystem.TotalVisibleMemorySize * 1KB
$FreeRamBytes = $OperatingSystem.FreePhysicalMemory * 1KB
$TotalRamGB = [math]::Round($TotalRamBytes / 1GB, 2)
$FreeRamGB = [math]::Round($FreeRamBytes / 1GB, 2)
$UsedRamGB = [math]::Round($TotalRamGB - $FreeRamGB, 2)

$Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$DiskSizeGB = [math]::Round($Disk.Size / 1GB, 2)
$DiskFreeGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
$DiskUsedGB = [math]::Round($DiskSizeGB - $DiskFreeGB, 2)
$DiskFreePercent = [math]::Round(($Disk.FreeSpace / $Disk.Size) * 100, 2)

$NetworkInfo = Get-NetIPConfiguration
$IpAddress = $NetworkInfo.IPv4Address.IPAddress

$NetworkAdapters = Get-NetAdapter

$ImportantServices = Get-Service -Name wuauserv, Spooler, WinDefend

$Warnings = @()
if ($DiskFreePercent -lt 15) {
    $Warnings += "Low disk space warning: C: drive free space is below 15%."
}
if ($UptimeDays -gt 7) {
    $Warnings += "High uptime warning: Computer has been running for more than 7 days."
}

$StoppedServices = $ImportantServices | Where-Object Status -ne "Running"

if ($StoppedServices) {
    $Warnings += "Service warning: Not running - $($StoppedServices.DisplayName)"
}

$DisabledAdapters = $NetworkAdapters | Where-Object Status -eq "Disabled"

if ($DisabledAdapters) {
    $Warnings += "Network warning: One or more network adapters are disabled."
}
if ($Warnings.Count -eq 0) {
    $Warnings += "No major warnings found."
}

$SystemReport = [PSCustomObject]@{
    ComputerName         = $ComputerName
    LoggedInUser         = $LoggedInUser
    ReportDate           = $CurrentDate
    WindowsVersion       = $WindowsVersion
    WindowsBuild         = $WindowsBuild
    LastBootTime         = $LastBootTime
    UptimeDays           = $UptimeDays
    CpuName              = $CpuName
    CpuCores             = $CpuCores
    CpuLogicalProcessors = $CpuLogicalProcessors
    TotalRamGB           = $TotalRamGB
    UsedRamGB            = $UsedRamGB
    FreeRamGB            = $FreeRamGB
    DiskSizeGB           = $DiskSizeGB
    DiskUsedGB           = $DiskUsedGB
    DiskFreeGB           = $DiskFreeGB
    DiskFreePercent      = $DiskFreePercent
    IpAddress            = $IpAddress
    Warnings             = $Warnings -join "; "
}

$TxtContent = @"
IT System Health Check Report

Computer Name: $ComputerName
Logged-in User: $LoggedInUser
Report Date: $CurrentDate

Windows Version: $WindowsVersion
Windows Build: $WindowsBuild
Last Boot Time: $LastBootTime
Uptime Days: $UptimeDays

CPU Name: $CpuName
CPU Cores: $CpuCores
CPU Logical Processors: $CpuLogicalProcessors

Total RAM: $TotalRamGB GB
Used RAM: $UsedRamGB GB
Free RAM: $FreeRamGB GB

Disk Size: $DiskSizeGB GB
Disk Used: $DiskUsedGB GB
Disk Free: $DiskFreeGB GB
Disk Free Percent: $DiskFreePercent%

IP Address: $IpAddress

Warnings:
$($Warnings -join "`n")
"@
$TxtContent | Out-File -FilePath $TxtReport
$SystemReport | Export-Csv -Path $CsvReport -NoTypeInformation
$HtmlContent = @"
<html>
<head>
<title>IT System Health Check Report</title>
<style>
body {
    font-family: Arial;
    margin: 30px;
}

h1 {
    margin-bottom: 20px;
}

.section {
    margin-bottom: 25px;
}

.label {
    font-weight: bold;
}
</style>
</head>
<body>
<h1>IT System Health Check Report</h1>

<div class="section">
<p><span class="label">Computer Name:</span> $ComputerName</p>
<p><span class="label">Logged-in User:</span> $LoggedInUser</p>
<p><span class="label">Report Date:</span> $CurrentDate</p>
</div>

<div class="section">
<p><span class="label">Windows Version:</span> $WindowsVersion</p>
<p><span class="label">Windows Build:</span> $WindowsBuild</p>
<p><span class="label">Last Boot Time:</span> $LastBootTime</p>
<p><span class="label">Uptime Days:</span> $UptimeDays</p>
</div>

<div class="section">
<p><span class="label">CPU Name:</span> $CpuName</p>
<p><span class="label">CPU Cores:</span> $CpuCores</p>
<p><span class="label">CPU Logical Processors:</span> $CpuLogicalProcessors</p>
</div>

<div class="section">
<p><span class="label">Total RAM:</span> $TotalRamGB GB</p>
<p><span class="label">Used RAM:</span> $UsedRamGB GB</p>
<p><span class="label">Free RAM:</span> $FreeRamGB GB</p>
</div>

<div class="section">
<p><span class="label">Disk Size:</span> $DiskSizeGB GB</p>
<p><span class="label">Disk Used:</span> $DiskUsedGB GB</p>
<p><span class="label">Disk Free:</span> $DiskFreeGB GB</p>
<p><span class="label">Disk Free Percent:</span> $DiskFreePercent%</p>
</div>

<div class="section">
<p><span class="label">IP Address:</span> $IpAddress</p>
</div>

<div class="section">
<h2>Warnings</h2>
<p>$($Warnings -join "<br>")</p>
</div>

</body>
</html>
"@
$HtmlContent | Out-File -FilePath $HtmlReport

Write-Host "System health check completed."
Write-Host "Reports saved in the reports folder."
