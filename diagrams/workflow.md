# Workflow Diagram

```text
User runs PowerShell script
        |
        v
Script collects system information
        |
        v
Script checks for common warning signs
        |
        v
Script creates TXT, CSV, and HTML reports
        |
        v
Raw reports stay local and private
        |
        v
Sanitized sample reports are added to GitHub
```

## Workflow Notes

The script runs locally on a Windows computer.

It collects basic system health information such as Windows version, uptime, RAM, disk space, IP address, network adapter status, and important service status.

The script then creates reports that could be used for basic help desk troubleshooting or saved with a support ticket.

Raw reports from the test computer are kept private. The repository uses sanitized sample reports instead.