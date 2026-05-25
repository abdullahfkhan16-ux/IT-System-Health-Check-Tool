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

