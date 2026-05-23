<#
Project: IT System Health Check Tool
File: system-health-check.ps1
Purpose: Collect basic Windows system health information for IT support troubleshooting.

Author: Abdullah Khan
#>

$ReportFolder = ".\reports"

if (!(Test-Path $ReportFolder)){
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