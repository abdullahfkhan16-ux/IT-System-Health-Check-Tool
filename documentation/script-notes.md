# Script Notes

## Script Purpose

The PowerShell script will collect useful system health information from a Windows computer.

The goal is to make a simple tool that could help an IT support technician gather information before troubleshooting or escalating a ticket.

## Information the Script Will Collect

The script should collect:

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
- Important service status
- Windows Update service status
- Print Spooler service status
- Recent system errors, if reasonable

## Warning Checks

The script should show warnings for common support issues, such as:

- Low disk space
- High system uptime
- Stopped services
- Disabled network adapters

## Planned Output Files

The script should create reports in these formats:

- TXT
- CSV
- HTML

## Notes While Building

This section will be updated while the script is being built and tested.

## Build Notes

This file will be updated while the script is being built.

The notes will explain the main PowerShell commands used in the script and why they were added.