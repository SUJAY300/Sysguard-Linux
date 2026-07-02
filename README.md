# SysGuard

> A modular Linux System Monitoring & Automation Toolkit built with Bash.

SysGuard is a production-inspired Linux monitoring tool that collects system information, monitors resource usage, generates reports, and provides a clean command-line interface.

It was built as a learning project to strengthen Linux, Bash scripting, automation, and software engineering fundamentals.

---

## Features

### System Information
- Hostname
- Current User
- Current Date & Time
- Kernel Version
- Architecture
- Shell
- Uptime

### Resource Monitoring
- CPU Usage & Health
- Memory Usage & Health
- Disk Usage & Health

### Network Monitoring
- Local IP Address
- Internet Connectivity

### Process Monitoring
- Top CPU-consuming Processes
- Top Memory-consuming Processes

### Reporting
- Terminal Dashboard
- Timestamped Text Reports
- JSON Export
- CSV Export
- Log File Generation

### CLI Support
- `--help`
- `--version`
- `--report`
- `--json`
- `--csv`
- `--watch <seconds>`

---

## Project Structure

```
sysguard/
├── config/
├── docs/
├── logs/
├── modules/
├── reports/
├── install.sh
├── uninstall.sh
├── sysguard.sh
├── README.md
├── LICENSE
└── .gitignore
```

---

## Installation

```bash
chmod +x install.sh
./install.sh
```

Run from anywhere:

```bash
sysguard
```

---

## Usage

```bash
sysguard

sysguard --report

sysguard --json

sysguard --csv

sysguard --watch 5

sysguard --help
```

---

## Requirements

- Linux or WSL2 (Ubuntu)
- Bash 5+
- Standard GNU Utilities

---

## Technologies Used

- Bash
- Linux
- GNU Coreutils
- awk
- grep
- ps
- df
- free
- top
- ping

---

## Learning Objectives

- Linux Fundamentals
- Bash Scripting
- Automation
- System Monitoring
- Logging
- Configuration Management
- Modular Software Design
- Git Workflow

---

## Roadmap

### ✅ v1.0
- Bash Monitoring Toolkit

### 🚀 Future
- Python Rewrite
- REST API
- Docker Support
- Web Dashboard

---

## License

MIT License