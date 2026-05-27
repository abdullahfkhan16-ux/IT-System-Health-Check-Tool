# Setup Notes

## Project Name

IT System Health Check Tool

## Purpose

The goal of this project is to create a PowerShell script that collects basic system health information from a Windows computer.

This is useful for help desk and desktop support work because technicians often need to check system details before troubleshooting or escalating an issue.

## Local Setup

The project was created locally on a Windows computer.

The folder structure was created first so the project would stay organized before writing the PowerShell script.

## Folder Structure

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

## Tools Used

- Windows
- PowerShell
- Visual Studio Code
- Git
- GitHub

## Setup Summary

The project was built locally first.

The main project folders were created before the script was written. This kept the files organized from the start.

The PowerShell script was written and tested on a local Windows laptop.

Git was used to track changes during the project. The project was then pushed to GitHub.

## Report Privacy

The raw reports created by the script are not pushed to GitHub because they include real device information from my laptop.

This can include:

- Computer name
- Logged-in username
- Local IP address
- System details

A `.gitignore` file was added to keep the raw generated reports private.

The repository includes sanitized sample reports instead. These sample reports show what the output looks like without sharing personal device details.

## GitHub Setup

A GitHub repository was created for this project so the script, documentation, sample reports, screenshots, and workflow notes could be stored in one place.

The repository includes:

- PowerShell script
- README file
- Setup notes
- Script notes
- Workflow notes
- Sanitized sample reports
- Project screenshots

## Screenshot Notes

Only screenshots that help explain the project are included.

The screenshots show:

- The script open in VS Code
- The script running successfully in the terminal
- The sanitized HTML sample report

Screenshots avoid raw report content, personal folders, private files, and browser tabs with personal information.