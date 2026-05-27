# Script Notes

## Script Purpose

The PowerShell script collects useful system health information from a Windows computer.

The goal is to make a simple tool that could help an IT support technician gather information before troubleshooting or escalating a ticket.

The script does not make changes to the computer. It only collects information and creates reports.

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

The warning checks are meant to point out items that may need review. They do not always mean the computer is broken.

For example, Windows Update may show as not running if it is not actively checking for updates at that moment.

## Output Files

The script creates reports in these formats:

- TXT
- CSV
- HTML

The TXT report is easy to read or copy into a ticket.

The CSV report can be opened in Excel.

The HTML report gives a cleaner browser view of the system health check.

## Main Script Sections

The script is organized into these main parts:

1. Set the report folder and report file names.
2. Collect basic computer and user information.
3. Collect Windows version and uptime information.
4. Collect CPU, RAM, and disk information.
5. Collect IP address and network adapter information.
6. Check important Windows services.
7. Create warning messages.
8. Create a main report object for CSV output.
9. Create TXT, CSV, and HTML reports.
10. Show a completion message in the terminal.

## PowerShell Commands Used

The main PowerShell commands used in the script include:

- `Test-Path` to check if the reports folder exists
- `New-Item` to create the reports folder if needed
- `Get-CimInstance` to collect Windows, CPU, RAM, and disk information
- `Get-NetIPConfiguration` to collect IP address information
- `Get-NetAdapter` to check network adapter status
- `Get-Service` to check important Windows services
- `Where-Object` to filter stopped services and disabled adapters
- `Out-File` to create TXT and HTML reports
- `Export-Csv` to create the CSV report
- `Write-Host` to show a simple completion message

## Report Privacy

The script was tested locally on my own Windows laptop.

The raw reports included real device information, such as computer name, username, and local IP address. Those raw reports were kept private and ignored with `.gitignore`.

The reports included in the repository are sanitized sample reports. They use test values instead of my real computer name, username, and IP address.

## First Working Version

The first working version of the script collects basic Windows system health information and creates TXT, CSV, and HTML reports.

The first version includes warning checks for low disk space, high uptime, stopped services, and disabled network adapters.

## Future Improvement Notes

A future version could include:

- A cleaner event log section that shows recent system errors in a readable format
- Better handling for computers with multiple network adapters
- An option to choose which services to check
- Timestamped report file names so each run creates a separate report