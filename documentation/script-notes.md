# Script Notes

## Script Purpose

The PowerShell script collects useful system health information from a Windows computer.

The goal is to make a simple tool that could help an IT support technician gather information before troubleshooting or escalating a ticket.

## Information the Script Collects

The script collects:

- Computer name
- Logged-in user
- Report date
- Windows version and build
- Last boot time
- System uptime
- CPU information
- RAM usage
- Disk space
- IP address
- Network adapter status
- Important Windows services
- Basic warning messages

## Warning Checks

The script shows warnings for common support issues, such as:

- Low disk space
- High system uptime
- Stopped services
- Disabled network adapters

## Output Files

The script creates reports in these formats:

- TXT
- CSV
- HTML

## Build Notes

The script was built in small sections so each part could be tested and understood.

The main PowerShell commands used in the script include:

- `Get-CimInstance` to collect Windows, CPU, RAM, and disk information
- `Get-NetIPConfiguration` to collect IP address information
- `Get-NetAdapter` to check network adapter status
- `Get-Service` to check important Windows services
- `Out-File` to create TXT and HTML reports
- `Export-Csv` to create the CSV report

## First Working Version

The first working version of the script collects basic Windows system health information and creates TXT, CSV, and HTML reports.

The warning section checks for low disk space, high uptime, stopped services, and disabled network adapters.

The script was tested locally on my own Windows laptop. The raw reports included real device information, so they were kept private and ignored with `.gitignore`.

The reports included in the repository are sanitized sample reports. They use test values instead of my real computer name, username, and IP address.

## Future Improvement Notes

A future version could include a cleaner event log section that shows recent system errors in a readable format.