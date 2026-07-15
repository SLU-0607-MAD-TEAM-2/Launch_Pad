# Changelog

## Week 3 (July 15, 2026)

### Screens Connected to JSON Data
| Screen | Data Source | JSON File |
|---|---|---|
| Swipe / Discovery | User profiles | `assets/data/profiles.json` |
| Explore | Startup projects | `assets/data/projects.json` |
| Messages | Conversations | `assets/data/messages.json` |
| Matches | Match records | `assets/data/matches.json` |
| Applications | Application records | `assets/data/applications.json` |

Data is loaded via `MockApiService` at app startup and distributed to screens through Provider (`DiscoveryProvider`, `SwipeProvider`, `MatchesProvider`, `ChatProvider`).

### New Form Added
**Feedback Screen** (`lib/screens/feedback/feedback_screen.dart`)
- Fields: Full Name, Email, Category (dropdown), Star Rating (1–5), Comments (multiline)
- Accessible from: Settings > Send Feedback
- Navigates via route `/feedback`

### Validation Rules
| Form | Field | Rule |
|---|---|---|
| Login | Email | Required, valid email format (regex) |
| Login | Password | Required, minimum 6 characters |
| Edit Profile | Full Name | Required |
| Edit Profile | Professional Role | Required |
| Edit Profile | Location | Required |
| Edit Profile | Short Bio | Required |
| Feedback | Full Name | Required |
| Feedback | Email | Required, valid email format (regex) |
| Feedback | Category | Required (must select one) |
| Feedback | Rating | Required (must select 1–5 stars) |
| Feedback | Comments | Required, minimum 10 characters |

### Error Handling
- `MockApiService.loadAll()` wrapped in try/catch
- Added `isLoaded`, `hasError`, `errorMessage` properties for state tracking
- App gracefully handles missing or malformed JSON data

### Bug Fixes
- Fixed `ExploreScreen` compile error: replaced undefined `mockProjects` reference with `DiscoveryProvider.projects` from JSON data
