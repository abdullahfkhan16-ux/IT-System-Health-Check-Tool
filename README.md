# IT System Health Check Tool

## Project Overview

This project is a PowerShell tool that checks basic system health information on a Windows computer.

I created this project to practice IT support automation for help desk and desktop support work. In a support role, a technician may need to collect computer details before troubleshooting or escalating an issue. This script helps collect that information in one place.

## What the Tool Checks

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

The script checks for common support issues such as:

- Low disk space
- High system uptime
- Stopped important services
- Disabled network adapters

## Why This Is Useful

This tool can help with basic troubleshooting.

For example, it can help check if a computer has low disk space, has been running for too long, has network adapter issues, or has stopped services.

Instead of checking each item manually, the script creates reports that can be saved with a support ticket or used before escalation.

## Report Formats

The script creates reports in these formats:

- TXT report
- CSV report
- HTML report

## Sample Reports

The script was tested locally on my own Windows laptop.

The raw reports created by the script include real device information, such as computer name, username, and local IP address. Those raw reports are kept private and ignored with `.gitignore`.

The repository includes sanitized sample reports in the `reports` folder. These files show what the output looks like without sharing personal device details.

Sample files:

- `reports/sample-system-health-report.txt`
- `reports/sample-system-health-report.csv`
- `reports/sample-system-health-report.html`

## Tools Used

- Windows 10 or Windows 11
- PowerShell
- Visual Studio Code
- Git
- GitHub

## Project Folder Structure

```text
IT-System-Health-Check-Tool
│
├── documentation
│   ├── setup-notes.md
│   └── script-notes.md
│
├── diagrams
│   └── workflow.md
│
├── reports
│   ├── sample-system-health-report.txt
│   ├── sample-system-health-report.csv
│   └── sample-system-health-report.html
│
├── screenshots
│   ├── script-open-vscode.png
│   ├── script-success-terminal.png
│   └── sample-html-report.png
│
├── scripts
│   └── system-health-check.ps1
│
├── .gitignore
└── README.md
```

## How to Run the Script

Open PowerShell from the main project folder and run:

```powershell
.\scripts\system-health-check.ps1
```

The script creates report files inside the `reports` folder.

Generated raw reports:

- `reports/system-health-report.txt`
- `reports/system-health-report.csv`
- `reports/system-health-report.html`

These generated raw reports are ignored by Git because they may contain real system information.

## Screenshots

The `screenshots` folder includes a small set of screenshots showing:

- The PowerShell script open in VS Code
- The script running successfully in the terminal
- The sanitized HTML report output

## Workflow

A simple workflow diagram is included here:

```text
diagrams/workflow.md
```

## What I Would Improve

In a future version, I would improve the tool by adding:

- A cleaner event log section for recent system errors
- Better handling for computers with multiple network adapters
- An option to choose which services to check
- A timestamped report file name so each run creates a separate report
- A simple prompt that lets the technician choose TXT, CSV, HTML, or all report types

## Project Status

First working version completed.

The script runs locally, creates TXT, CSV, and HTML reports, and includes basic warning checks for common support issues.