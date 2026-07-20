# LaunchPad

A mobile matching platform for people who want to start tech or media projects but don't have a team. Instead of swiping for dates, users swipe to find co-founders, developers, and designers — think "Tinder meets a startup job board" for the modern creator and tech ecosystem.

## Project Vision

Aspiring founders with a great idea but no technical skills, and developers/designers with skills but no exciting project, end up spamming WhatsApp groups, Discord servers, and LinkedIn feeds hoping someone responds. LaunchPad replaces that chaos with a focused, swipe-and-apply discovery experience that matches complementary people quickly, then hands them straight into a chat to start building.

## Objectives

- **Kill the social media chaos** — stop idea-spamming across scattered group chats and feeds.
- **Bridge the skill gap** — connect non-technical founders with developers/designers who have the exact skills a project needs.
- **Make team building fast** — a recommended feed plus a searchable Explore tab gets people to a relevant project or teammate in seconds.
- **Get from application to building, fast** — every application can open directly into a chat so people can share a Figma link or repo and start collaborating immediately.

## Target Users

| Role | Description | Primary Needs |
|---|---|---|
| **Founders / Idea People** | Have an app or business idea but can't code or design it themselves | Recruit developers/designers via "Recommended Teammates," showcase their project clearly, review applications |
| **Developers** | Have technical skills but lack an exciting project or want portfolio experience | Discover projects via "Recommended Startups" and Explore search/filters, see clear terms (equity, duration, location), apply directly |
| **Creatives / Designers** | UI/UX designers, video editors, and digital marketers wanting real-world team experience | Same as developers — fast discovery, clear expectations, a way to build a real-world portfolio |

## Core Features (per current wireframes)

1. **Home Feed — Recommended Startups / Recommended Teammates** — a swipeable card feed (pass / interested) personalized to the signed-in user's role
2. **Explore** — keyword search plus tag filters (Remote, On-site, AI, EdTech, etc.), with Trending/New badges on project cards
3. **Apply to Join** — direct application action from both the Home feed and Explore listings
4. **Messages** — conversation list showing the other person's role tag (Founder, UI Designer, etc.) and unread indicators, opening into a real-time chat
5. **Profile** — verified badge, location & remote preference, role tag, bio, a "Technical Arsenal" of skill tags, and Connect links (Portfolio, GitHub, LinkedIn)

## Navigation Flow

```
Login / Sign-up (planned — not yet in current wireframe set)
        │
        ▼
Home (Recommended Startups / Recommended Teammates — swipe feed)
        │
   ┌────┼─────────────┬───────────────┐
   ▼    ▼              ▼               ▼
Explore  Apply to Join  Messages ──> Chat   Profile
(search/filter)                (conversation list)
```

## Project Structure

```
launchpad_flutter_app/
├── lib/
│   ├── main.dart
│   ├── screens/
│   │   ├── auth/          # login_screen.dart, role_selection_screen.dart (planned)
│   │   ├── home/          # home_feed_screen.dart (Recommended Startups / Teammates)
│   │   ├── explore/       # explore_screen.dart (search + filters)
│   │   ├── messages/      # messages_list_screen.dart, chat_screen.dart
│   │   └── profile/       # profile_screen.dart
│   ├── widgets/           # Reusable UI components (startup card, chat bubble, etc.)
│   ├── models/            # user_profile.dart, startup_project.dart, application.dart
│   ├── services/          # auth_service.dart, firestore_service.dart
│   ├── providers/         # swipe_provider.dart (state management)
│   └── utils/             # date_formatter.dart
├── assets/
│   ├── images/
│   └── icons/
├── test/
├── pubspec.yaml
├── .gitignore
└── README.md
```

## Tech Stack

- **Framework:** Flutter (Dart)
- **State management:** Provider
- **Backend:** Firebase (Auth, Firestore for profiles/projects/applications, Storage for images)
- **Swipe cards:** `flutter_card_swiper`
- **Links:** `url_launcher` for opening Portfolio/GitHub/LinkedIn links

## Design

Wireframes for the Home, Explore, Messages, and Profile screens were designed by the team's UX designer. A Login/Role Selection screen is planned but not yet included in the current wireframe set.

## Development Roadmap

- **Week 1:** Proposal, wireframes, project setup ✅ (this repo)
- **Week 2:** Build static UI screens (Home, Explore, Messages, Profile, and Login) ✅
- **Week 3:** Connected screens to JSON data, added feedback form with validation, added error handling, implemented animations across multiple screens ✅
- **Week 4+:** Wire up Firebase (auth, applications, real-time chat), push notifications

## Week 2 Deliverable

### Status: Fully Functional UI Prototype

### Requirements Met
- Minimum 4 interactive screens
- Full navigation between all pages
- Responsive, error-free layout
- Clear commit history
- Documentation & screenshots included

### Core Screens Implemented

#### Login Screen
- Modern, responsive design
- Smooth entrance animation
- Email/password fields + Google sign-in option
- Direct navigation to Home screen

#### Home / Swipe Match Screen
- Swipeable profile cards
- Search bar + skill/industry filters
- Working action buttons: Skip, Save, Connect
- No layout crashes or overflow

#### Matches & Messages Screen
- Horizontal "stories-style" list of new matches
- Vertical conversation list with timestamps and unread indicators
- Clean, easy-to-read layout

#### Profile & Edit Profile Screen
- Full user profile view
- Fully functional Edit Profile form
- Updates saved instantly, responsive on all screen sizes
- Links for GitHub & LinkedIn

### Screenshots


|
 Login Screen 
|
 Swipe Match Screen 
|
|
---
|
---
|
|
!
[
Login Screen
](
assets/images/week3_screenshots/login.png
)
|
!
[
Swipe Screen
](
assets/images/week3_screenshots/swipe.png
)
|


|
 Matches Screen 
|
 Profile & Edit Profile 
|
|
---
|
---
|
|
!
[
Matches Screen
](
assets/images/week3_screenshots/matches.png
)
|
!
[
Profile Screen
](
assets/images/week3_screenshots/profile.png
)
|

## Week 3 Changes

### Data Integration
- Connected screens to JSON data (`profiles.json`, `projects.json`, `matches.json`, `messages.json`, `applications.json`)
- Added `MockApiService` to load all data from `assets/data/`
- Explore screen now fetches projects via `DiscoveryProvider`
- Swipe/Discovery screens load user profiles from JSON

### New Screens
- Added feedback form with name, email, category dropdown, star rating, and comments
- Added onboarding carousel (3 slides: Founders, Developers, Designers) with skip button and shared_preferences

### Forms & Validation
- Added login form with email format and password length validation
- Added edit profile form with validation on name, role, location, and bio
- Added feedback form with required fields and minimum character limits

### Error Handling
- Wrapped data loading in try/catch with error state handling
- App gracefully handles missing or malformed JSON data
- Forms show inline validation errors on submit

### Animations
- Added splash screen with 3-phase logo animation
- Added login screen with staggered entrance animation
- Added swipe screen match overlay with confetti burst on match
- Added shimmer skeleton loading on SwipeScreen and MessagesListScreen
- Added staggered slide-in animation on MessagesListScreen conversations
- Added Hero transitions on ExploreScreen project cards to ProjectDetailsScreen
- Added reusable `ScaleTap` press-feedback widget
- Added custom `LaunchPadLoading` indicator
- Added global page transitions (fade + slide)
- Added micro-animations for layout changes and content crossfades

### New Features
- Added compatibility score badge on swipe cards (skill-match percentage)
- Added filter bottom sheet on DiscoveryScreen (Role, Remote Only, Availability)
- Added My Applications section in ProfileScreen with status chips (Pending/Accepted/Rejected)
- Added Saved Profiles section in ProfileScreen
- Unified theme files into single `app_theme.dart` (merged AppColor, AppTypography, AppShapes, AppGradients, AppSpacing)
- Wired NavProvider to MainShell for bottom nav state management
- Connected ChatProvider to ChatScreen for message loading
- Fixed Sign Up screen to match login screen design and navigate correctly
- Removed Apple sign-up button from SignUpScreen

### Bug Fixes
- Fixed `ExploreScreen` referencing undefined `mockProjects` variable
- Fixed ChatScreen constructor to accept name, avatar, and optional userId
- Fixed role_selection_screen missing MainShell import
- Fixed widget_test.dart to pass required apiService parameter
- Removed duplicate screens (home/explore_screen, profile/settings_screen, launchpad_loading, swipe_discovery_screen, home_feed_screen)

## Version Control Log
- Repository initialized and scaffolded locally.
- Pushed to `SLU-0607-MAD-TEAM-2/Launch_Pad` on GitHub by Joshua Gomez (Documentation & Version Control Manager), July 12 2026.

## How to Run Locally

```bash
# Clone the repository
git clone https://github.com/SLU-0607-MAD-TEAM-2/Launch_Pad.git

# Navigate into project folder
cd Launch_Pad

# Install dependencies
flutter pub get

# Run on web / emulator
flutter run -d chrome
```

## Team

SLU 0607 Mobile Application Development (MAD) — Team 2
