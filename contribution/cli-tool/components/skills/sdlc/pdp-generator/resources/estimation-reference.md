# Quick Estimation Reference Table

## Ranges by Type (MH): Min | Typical | Max

### Frontend
| Task | Min | Typical | Max |
|------|-----|---------|-----|
| Simple UI component | 2 | 3 | 4 |
| Standard form | 4 | 6 | 8 |
| Complex form | 8 | 12 | 16 |
| List view + filters | 8 | 12 | 16 |
| Dashboard with charts | 16 | 24 | 32 |
| Multi-step wizard | 16 | 20 | 24 |
| Interactive map | 12 | 18 | 24 |

### Backend
| Task | Min | Typical | Max |
|------|-----|---------|-----|
| Simple CRUD | 4 | 6 | 8 |
| CRUD with validations | 8 | 12 | 16 |
| Complex logic API | 16 | 24 | 32 |
| REST integration | 8 | 16 | 24 |
| SOAP integration | 16 | 28 | 40 |
| Notifications | 16 | 20 | 24 |
| Roles and permissions | 16 | 24 | 32 |
| Background jobs | 12 | 18 | 24 |
| File processing | 8 | 12 | 16 |

### Infra
| Task | Min | Typical | Max |
|------|-----|---------|-----|
| Docker setup | 4 | 6 | 8 |
| Basic CI/CD | 8 | 12 | 16 |
| Full CI/CD | 16 | 24 | 32 |
| Basic IaC | 16 | 20 | 24 |
| Monitoring | 8 | 12 | 16 |

### QA
| Task | Min | Typical | Max |
|------|-----|---------|-----|
| Unit tests/module | 8 | 12 | 16 |
| Integration tests | 12 | 18 | 24 |
| E2E tests | 16 | 24 | 32 |
| Perf testing | 16 | 20 | 24 |

## Context Multipliers
| Factor | x |
|--------|---|
| Greenfield | 1.0 |
| Legacy | 1.3-1.5 |
| Ambiguous requirements | 1.2-1.4 |
| APIs without docs | 1.5 |
| Compliance | 1.3 |
| Multi-language | 1.2 |
| Multi-tenant | 1.3-1.5 |

## Buffer
| Clarity | % |
|---------|---|
| Well defined | +15% |
| Moderate | +25% |
| Exploratory | +35% |
