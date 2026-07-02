# SysGuard Architecture

```
                 +----------------------+
                 |     sysguard.sh      |
                 +----------+-----------+
                            |
             +--------------+--------------+
             |                             |
     Configuration                 Module Loader
             |                             |
             +--------------+--------------+
                            |
        +---------+---------+---------+---------+
        |         |         |         |         |
     System      CPU      Memory    Disk    Network
        |         |         |         |         |
        +---------+---------+---------+---------+
                            |
                      Report Generator
                            |
                 +----------+----------+
                 |                     |
              Terminal              Reports
                 |
               Logger
```

---

## Design Principles

- One responsibility per module
- Shared helper functions
- Configurable thresholds
- No duplicated code
- Easy to extend
- Consistent outputs
- Simple interfaces

---

## Module Responsibilities

### system.sh

Collect OS information.

### cpu.sh

Collect processor statistics.

### memory.sh

Collect RAM information.

### disk.sh

Collect storage information.

### network.sh

Collect network information.

### process.sh

Collect process statistics.

### logger.sh

Logging abstraction.

### report.sh

Report generation.

### utils.sh

Reusable helper functions.