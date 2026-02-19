---
name: changelog
description: >
  Generate a functional changelog from git commits. Summarizes what changed,
  groups by type, and produces a clean release-ready document.
  Trigger: "changelog", "release notes", "what changed", "summarize commits",
  "generate changelog", "what did we ship".
---

# Changelog Generator

Generate a clear, functional changelog from git history.

## Input

`$ARGUMENTS` may contain:
- A version tag or range: `v1.0.0..v2.0.0`, `v1.2.0`, `last 2 weeks`
- A number of commits: `last 10`, `last 20`
- A branch comparison: `main..feature/xyz`
- Nothing (default: all commits since last tag, or last 20 if no tags)

## Workflow

### Step 1: Gather commits

Run git commands to collect the commit history:

1. If a range was specified, use it: `git log {range} --pretty=format:"%H|||%s|||%an|||%ad" --date=short`
2. If "last N" was specified: `git log -N --pretty=format:"%H|||%s|||%an|||%ad" --date=short`
3. If nothing specified:
   - Check for the latest tag: `git describe --tags --abbrev=0 2>/dev/null`
   - If a tag exists: `git log {tag}..HEAD --pretty=format:"%H|||%s|||%an|||%ad" --date=short`
   - If no tags: `git log -20 --pretty=format:"%H|||%s|||%an|||%ad" --date=short`

### Step 2: Analyze changes

For each commit, read the commit message. If the message is unclear or too terse, check the diff:
`git diff-tree --no-commit-id --name-status -r {hash}`

Classify each commit by type based on conventional commit prefixes or content:
- **Added** — new features (`feat:`)
- **Changed** — enhancements to existing features (`refactor:`, `perf:`, improvements)
- **Fixed** — bug fixes (`fix:`)
- **Removed** — deleted features or code
- **Infrastructure** — CI/CD, deps, config (`chore:`, `ci:`, `build:`)
- **Docs** — documentation changes (`docs:`)

### Step 3: Generate changelog

Produce a markdown document with this structure:

```markdown
# Changelog — {project name}

## [{version or date range}] — {date}

### Added
- {functional description of what was added and why it matters}

### Changed
- {what was improved and the user-facing impact}

### Fixed
- {what was broken and how it was resolved}

### Removed
- {what was removed and why}

### Infrastructure
- {CI/CD, dependency, or config changes}

### Docs
- {documentation changes}
```

## Rules

1. **Write functional summaries, not commit messages** — "Users can now filter search results by date" not "feat: add date filter to search"
2. **Group related commits** — 3 commits about "auth" become one changelog entry
3. **Skip noise** — merge commits, formatting-only changes, and trivial fixes can be omitted unless relevant
4. **User perspective** — describe what changed for the user or developer, not implementation details
5. **Include breaking changes** prominently with a WARNING prefix
6. **Keep it concise** — one line per change, expand only for breaking changes

## Output

Ask the user where to save:
- Default: print to conversation
- If requested: save to `CHANGELOG.md` (append at top, below the header)
- If requested: save to `docs/changelog-{date}.md`

## Examples

**Bad** (just repeating commits):
```
- feat: add search filter
- fix: search filter bug
- refactor: search component
```

**Good** (functional summary):
```
- Search results can now be filtered by date range, category, and status
```
