# Quick Estimation Reference Table — AI-Assisted Development

> These estimates assume a developer working with AI coding tools
> (Claude Code, Copilot, etc.). Roughly 40-60% of traditional hours.

## Ranges by Type (MH): Min | Typical | Max

### Frontend
| Task | Min | Typical | Max |
|------|-----|---------|-----|
| Simple UI component | 1 | 1.5 | 2 |
| Standard form | 2 | 3 | 4 |
| Complex form | 4 | 6 | 8 |
| List view + filters | 3 | 4.5 | 6 |
| Dashboard with charts | 6 | 9 | 12 |
| Multi-step wizard | 6 | 8 | 10 |
| Interactive map | 5 | 8 | 10 |

### Backend
| Task | Min | Typical | Max |
|------|-----|---------|-----|
| Simple CRUD | 1 | 2 | 3 |
| CRUD with validations | 3 | 4.5 | 6 |
| Complex logic API | 8 | 12 | 16 |
| REST integration | 4 | 8 | 12 |
| SOAP integration | 12 | 18 | 24 |
| Notifications | 4 | 6 | 8 |
| Roles and permissions | 6 | 9 | 12 |
| Background jobs | 4 | 7 | 10 |
| File processing | 3 | 5 | 8 |

### Infra
| Task | Min | Typical | Max |
|------|-----|---------|-----|
| Docker setup | 2 | 3 | 4 |
| Basic CI/CD | 3 | 4.5 | 6 |
| Full CI/CD | 6 | 9 | 12 |
| Basic IaC | 6 | 9 | 12 |
| Monitoring | 4 | 6 | 8 |

### QA
| Task | Min | Typical | Max |
|------|-----|---------|-----|
| Unit tests/module | 2 | 4 | 6 |
| Integration tests | 4 | 7 | 10 |
| E2E tests | 8 | 12 | 16 |
| Perf testing | 8 | 12 | 16 |

### Management & Review
| Task | Min | Typical | Max |
|------|-----|---------|-----|
| Kickoff + planning | 4 | 6 | 8 |
| Sprint planning (per sprint) | 2 | 3 | 4 |
| Code review + AI validation (per sprint) | 4 | 6 | 8 |
| Technical documentation | 4 | 6 | 8 |
| Go-live support | 4 | 6 | 8 |

## AI Impact by Area

| Phase | Time saved | Why |
|-------|-----------|-----|
| Boilerplate / CRUD | ~70% | AI generates most code |
| UI components | ~60% | Layouts, forms, lists are routine |
| Business logic | ~40% | AI helps, but logic needs human validation |
| External integrations | ~30% | Undocumented APIs still need manual effort |
| Architecture decisions | ~10% | Human judgment required |
| Security / auth | ~20% | Careful review still mandatory |
| Testing | ~50% | AI generates tests; edge cases need thought |
| DevOps / Infra | ~30% | Config-heavy, less AI leverage |

## Multipliers
| Factor | x |
|--------|---|
| Greenfield | 1.0 |
| Legacy | 1.3-1.5 |
| Ambiguous requirements | 1.2-1.4 |
| APIs without docs | 1.5 |
| Compliance | 1.3 |
| Multi-language | 1.2 |
| Multi-tenant | 1.3-1.5 |
| No AI tooling (client restriction) | 2.0 |

## Buffer
| Clarity | % |
|---------|---|
| Well defined | +15% |
| Moderate | +25% |
| Exploratory | +35% |
