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
$UpTime = (Get-Date) - $LastBootTime
$UpTimeDays = [math]:: Round.($UpTime.TotalDays, 1)

$Processor = Get-CimInstance Win32_Processor
$CpuName = $Processor.Name
$CpuCores = $Processor.NumberOfCores
$CpuLogicalProcessors = $Processor.NumberOfLogicalProcessors

$TotalRamBytes = $OperatingSystem.TotalVisibleMemorySize * 1KB
$FreeRamBytes = $OperatingSystem.FreePhysicalMemory * 1KB
$TotalRamGB = [math]:: Round($TotalRamBytes / 1GB, 2)
$FreeRamGB = [math]:: Round($FreeRamBytes / 1GB, 2)
$UsedRamGB = [math]:: Round($TotalRamGB - $FreeRamGB, 2)

$Disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
$DiskSizeGB = [math]::Round($Disk.Size / 1GB, 2)
$DiskFreeGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
$DiskUsedGB = [math]::Round($DiskSizeGB - $DiskFreeGB, 2)
$DiskFreePercent = [math]::Round(($Disk.FreeSpace / $Disk.Size) * 100, 2)

$NetworkInfo = Get-NetIPConfiguration
$IpAddress = $NetworkInfo.IPv4Address.IPAddress

$NetworkAdapters = Get-NetAdapter

$ImportantServices = Get-Service -Name wuauserv, Spooler, WinDefend

$RecentSystemErrors = Get-EventLog -LogName System -EntryType Error -Newest 5
$Warnings = @()
if ($DiskFreePercent -lt 15) {
    $Warnings += "Low disk space warning: C: drive free space is below 15%."
}
if ($UptimeDays -gt 7) {
    $Warnings += "High uptime warning: Computer has been running for more than 7 days."
}

$StoppedServices = $ImportantServices | Where-Object Status -ne "Running"

if ($StoppedServices) {
    $Warnings += "Service warning: One or more important services are not running."
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
$HtmlContent = $SystemReport | ConvertTo-Html -Title "IT System Health Check Report" -PreContent "<h1>IT System Health Check Report</h1>"
$HtmlContent | Out-File -FilePath $HtmlReport

Write-Host "System health check completed."
Write-Host "Reports saved in the reports folder."
