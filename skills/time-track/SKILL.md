---
name: time-track
description: >
  Record time worked on a task or module. Maintains a log of
  actual hours to compare against PDP estimates and billing.
  Trigger: "log time", "time track", "hours", "I worked on",
  "how much have we spent", "hours report".
---

# Time Track: $ARGUMENTS

## Instructions

### Log time
Add a line to docs/timesheet.csv:
```
date,project,module,task,actual_mh,estimated_mh,notes
```
If it doesn't exist, create it with the headers.

### Check progress ("how much have we spent?")
Read timesheet.csv, group by module, compare with PDP if exists:

```
| Module | Est. MH | Actual MH | Deviation | Status |
|--------|---------|-----------|-----------|--------|
| Auth   | 32      | 28        | -12%      | OK     |
| Core   | 80      | 92        | +15%      | Warning|
| TOTAL  | 152     | 132       | -13%      | OK     |
```

### Monthly report ("hours report")
Summary grouped by project and module for the month.

### Automatic alert
If actual deviation > +25% on a module, proactively alert
and suggest reviewing scope or estimation.
