# IT System Health Check Tool

## Project Overview

This project is a PowerShell tool that checks basic system health information on a Windows computer.

I created this project to practice IT support automation. In a help desk role, a technician may need to collect computer details before troubleshooting or escalating an issue. This script helps collect that information in one place.

## What the Tool Checks

The script will collect information such as:

- Computer name
- Logged-in user
- Windows version
- Last boot time
- System uptime
- CPU information
- RAM information
- Disk space
- IP address
- Network adapter status
- Important Windows services
- Recent system errors

## Why This Is Useful

This tool can help with basic troubleshooting. For example, it can help check if a computer has low disk space, has been running for too long, has network adapter issues, or has stopped services.

Instead of checking each item manually, the script creates reports that can be saved with a support ticket or used before escalation.

## Report Formats

The goal is to generate:

- TXT report
- CSV report
- HTML report

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
├── scripts
├── reports
├── screenshots
└── diagrams