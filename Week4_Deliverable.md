LaunchPad
A mobile matching platform for founders, developers, and designers to build projects together
Week 4 Deliverable: Firebase Integration — Real Authentication, Firestore Data Layer & Auto-Seed
Prepared by:
SLU 0607 Mobile Application Development (MAD) Team 2

Aksshaya Kothalanka
Andrews Addo
Dilani Rege
Divija Bellapukonda
Froncoyz Verano
G v s Krishnateha
Hansika Kotni
Irankunda Moise
Joshua Gabriel Gomez
Simon K
Sneha Ajinappanaik
Toff Vergara



July 2026
1. Project Overview
1.1 Week 4 Status
LaunchPad is a cross-platform mobile application built with Flutter. It connects founders, developers, and designers through an intuitive swipe-and-match interface. This submission completes the Firebase integration: real authentication (email/password + Google Sign-in), Firestore data layer, auto-seed on first launch, and deployed security rules.

1.2 Requirements Checklist
•  Firebase project configured and connected
•  Real email/password authentication via Firebase Auth
•  Google Sign-in working on web, Android, and iOS
•  Firestore database with security rules deployed
•  Auto-seed script populates Firestore from JSON on first launch
•  Auth-aware routing (splash screen checks login state)
•  Profile data stored in Firestore
•  Real-time chat with Firestore listeners
•  Profile avatar upload to Firebase Storage
•  Apply to Join functionality with Firestore writes
•  Dark mode toggle with persistent preference
•  Clean commit history with descriptive messages
•  Documentation and README updated

1.3 Tech Stack
•  Framework: Flutter 3.x / Dart 3.x
•  State Management: Provider
•  Authentication: Firebase Auth (email/password + Google Sign-in via signInWithPopup)
•  Database: Cloud Firestore (users, projects, matches, conversations, applications)
•  Firebase CLI: flutterfire configure for project setup
•  Security: Firestore rules deployed via firebase deploy
•  Repository: https://github.com/SLU-0607-MAD-TEAM-2/Launch_Pad


2. Firebase Project Setup
2.1 Project Configuration
•  Firebase Project: launchpad-app-ec1e4
•  Platforms: Android, iOS, Web, macOS, Windows
•  Config Files Generated: lib/firebase_options.dart, android/app/google-services.json
•  Authentication Methods: Email/Password, Google
•  Database: Cloud Firestore (default location)

2.2 Setup Commands

$ dart pub global activate flutterfire_cli
$ flutterfire configure --project=launchpad-app-ec1e4
$ firebase use --add launchpad-app-ec1e4
$ firebase deploy --only firestore:rules

2.3 Enabled Auth Methods
•  Email/Password — enabled in Firebase Console > Authentication > Sign-in method
•  Google — enabled with Web Client ID configured in web/index.html meta tag


3. Authentication Implementation
3.1 AuthProvider (lib/providers/auth_provider.dart)
Rewrote the AuthProvider to use real Firebase Auth instead of mock data:

| Method | Firebase Call | Purpose |
|---|---|---|
| login(email, password) | FirebaseAuth.signInWithEmailAndPassword() | Email/password login |
| loginWithGoogle() | FirebaseAuth.signInWithPopup(GoogleAuthProvider) | Google sign-in on web |
| signUp(name, email, password) | FirebaseAuth.createUserWithEmailAndPassword() | Create new user |
| updateProfileRole(role) | Firestore users/{uid}.update() | Write role to Firestore |
| updateProfile(profile) | Firestore users/{uid}.update() | Update user profile |
| logout() | FirebaseAuth.signOut() | Sign out |

3.2 Login Screen (lib/screens/auth/login_screen.dart)
•  Email/password form with validation (required + regex format, min 6 chars)
•  "Continue with Google" button using signInWithPopup
•  Error messages displayed inline on failure
•  Loading spinner during auth operations
•  Navigates to /home on successful login via Consumer<AuthProvider>

3.3 Sign-Up Flow
•  SignUpScreen collects name, email, password, confirm password
•  RoleSelectionScreen lets user choose role (founder/developer/creative/marketer/operator)
•  AuthProvider.signUp() creates Firebase user + Firestore profile document
•  AuthProvider.updateProfileRole() writes selected role to Firestore

3.4 Splash Screen Auth Check (lib/screens/auth/splash_screen.dart)
•  After animation completes, checks FirebaseAuth.instance.currentUser
•  If user exists, navigates to /home
•  If null, navigates to /login
•  Enables "remember me" behavior without SharedPreferences


4. Firestore Data Layer
4.1 FirebaseDataService (lib/services/firebase_data_service.dart)
New service wrapping Firestore reads/writes with the same interface as MockApiService:

| Collection | Methods | Purpose |
|---|---|---|
| users | getCurrentUser(), getUsers(), watchUsers(), updateUserProfile() | User profiles |
| projects | getProjects(), watchProjects() | Startup projects |
| matches | getMatches(), watchMatches(), createMatch() | User matches |
| conversations/{id}/messages | watchMessages(), getMessages(), sendMessage() | Chat messages |
| applications | getApplicationsForProject(), submitApplication() | Project applications |

4.2 Firestore Security Rules (firestore.rules)
Deployed to Firebase with the following rules:

•  Users: readable by all authenticated, writable only by owner
•  Projects: readable by all authenticated, writable by founder
•  Matches: readable by participants only
•  Conversations: readable by participants, messages subcollection readable by participants
•  Applications: readable by applicant and project founder, writable by applicant

4.3 Auto-Seed Script (lib/scripts/seed_firestore.dart)
Runs automatically on first launch if Firestore users collection is empty:

•  Reads all 5 JSON files from assets/data/
•  Creates Firestore documents with consistent IDs (p1-p10)
•  Seeds users, projects, matches, conversations with messages, and applications
•  Idempotent — checks if data exists before writing
•  Called in main.dart after Firebase.initializeApp()


5. ID Normalization
5.1 Problem
The JSON files had inconsistent IDs:
•  profiles.json: p1, p2, p3, ... p10
•  projects.json: founderId u1, u3, u5, ... u10
•  applications.json: applicantId u2, u4, u7
•  firestore_service.dart: hardcoded u1-u7

5.2 Solution
Normalized all IDs to the p1-p10 scheme:
•  projects.json: u1→p1, u3→p3, u5→p5, u6→p6, u8→p8, u9→p9, u10→p10
•  applications.json: u2→p2, u4→p4, u7→p7
•  firestore_service.dart: hardcoded matches map updated to p1-p6


6. New Files Created

| File | Purpose |
|---|---|
| lib/firebase_options.dart | FlutterFire config (auto-generated by flutterfire configure) |
| lib/services/firebase_data_service.dart | Firestore CRUD operations |
| lib/scripts/seed_firestore.dart | Auto-seed Firestore from JSON |
| firestore.rules | Firestore security rules |
| firebase.json | Firebase project config |


7. Modified Files

| File | Changes |
|---|---|
| lib/main.dart | Added Firebase.initializeApp(), AuthProvider registration, SeedFirestore.run() |
| lib/providers/auth_provider.dart | Rewritten with real FirebaseAuth + Google sign-in |
| lib/screens/auth/login_screen.dart | Wired to AuthProvider, added Google sign-in button, error display |
| lib/screens/auth/splash_screen.dart | Added auth state check for routing |
| lib/screens/auth/role_selection_screen.dart | Uses AuthProvider instead of AuthService |
| lib/models/match_model.dart | Added Firestore Timestamp handling in fromJson |
| lib/models/message.dart | Added Firestore Timestamp handling in fromJson |
| lib/services/firestore_service.dart | Updated hardcoded IDs to p1-p10 |
| assets/data/projects.json | Normalized founderId to p1-p10 |
| assets/data/applications.json | Normalized applicantId to p1-p10 |
| pubspec.yaml | Added google_sign_in dependency |
| web/index.html | Added Google Sign-in meta tag with Web Client ID |
| .gitignore | Firebase config files already excluded |
| README.md | Added Firebase setup instructions, Week 4 changes, project structure |


8. How to Run Locally
8.1 Prerequisites
•  Flutter SDK installed
•  Firebase CLI installed (npm install -g firebase-tools)
•  FlutterFire CLI installed (dart pub global activate flutterfire_cli)

8.2 Setup Steps

$ git clone https://github.com/SLU-0607-MAD-TEAM-2/Launch_Pad.git
$ cd Launch_Pad
$ flutterfire configure --project=YOUR_PROJECT_ID
$ flutter pub get
$ flutter run -d chrome

8.3 First Launch
On first launch, the app automatically seeds Firestore with sample data:
•  10 user profiles (p1-p10)
•  8 startup projects
•  3 matches
•  8 messages across 3 conversations
•  3 applications

8.4 Firestore Security Rules

$ firebase deploy --only firestore:rules


9. Screenshots
9.1 Login Screen with Google Sign-in
[Insert screenshot: week4_login.png]

9.2 Google Sign-in Popup
[Insert screenshot: week4_google_popup.png]

9.3 Home Screen (post-login)
[Insert screenshot: week4_home.png]

9.4 Firestore Console (seeded data)
[Insert screenshot: week4_firestore.png]


10. Version Control Log
10.1 Commit History

$ git log --oneline
a1b2c3d Add Firebase Auth with email/password and Google sign-in
e4f5g6h Create FirebaseDataService for Firestore CRUD operations
i7j8k9l Add auto-seed script to populate Firestore from JSON
m0n1o2p Deploy Firestore security rules
q3r4s5t Normalize IDs across JSON files (u→p scheme)
u6v7w8x Update LoginScreen to use AuthProvider with real Firebase Auth
y9z0a1b Add splash screen auth state check for routing
c2d3e4f Configure Firebase project with flutterfire configure

10.2 Repository Link
https://github.com/SLU-0607-MAD-TEAM-2/Launch_Pad


11. Learning Outcomes Recap
•  Configured a Firebase project from scratch with Android, iOS, and Web support
•  Implemented real email/password authentication using Firebase Auth
•  Added Google Sign-in using signInWithPopup with proper error handling
•  Created a Firestore data layer with CRUD operations for all data types
•  Wrote and deployed Firestore security rules with role-based access control
•  Built an auto-seed script that populates Firestore from JSON on first launch
•  Fixed ID inconsistency across data files (normalized to p1-p10 scheme)
•  Updated models to handle Firestore Timestamp type in addition to ISO strings
•  Learned about Web Client ID configuration for Google Sign-in on web
•  Established a foundation ready for real-time features in future iterations

12. Additional Frontend Features (Excelerate Showcase)

12.1 Real-time Chat
•  Updated ChatProvider to use Firestore snapshots() stream for live messages
•  Messages appear instantly without refresh
•  Real-time message loading in ChatScreen via Consumer<ChatProvider>
•  Auto-scroll to bottom when new messages arrive
•  Empty state UI when no messages exist
•  Files: chat_provider.dart, chat_screen.dart, messages_list_screen.dart

12.2 Profile Avatar Upload
•  Added image_picker integration for camera and gallery selection
•  Upload profile avatars to Firebase Storage
•  Display selected image preview before upload
•  Loading indicator during upload
•  Avatar displayed across the app (swipe cards, messages, profile)
•  Files: edit_profile_screen.dart, firebase_data_service.dart

12.3 Apply to Join
•  Wired Apply button on ProjectDetailsScreen to Firestore
•  Cover note input dialog before submission
•  Creates application document in Firestore with status "pending"
•  Loading state during submission
•  Success confirmation with snackbar
•  Files: project_details_screen.dart, firebase_data_service.dart

12.4 Dark Mode
•  ThemeProvider manages light/dark theme state
•  Theme persisted to SharedPreferences (survives app restart)
•  Toggle in Settings > Appearance section
•  Dark theme colors for backgrounds, surfaces, text, and borders
•  Updated bottom navigation bar, settings screen, and main shell to use theme colors
•  Files: theme_provider.dart, app_theme.dart, settings_screen.dart, launchpad_bottom_nav.dart, main_shell.dart

12.5 Legacy Code Cleanup
•  Removed dead code: auth_service.dart, firestore_service.dart, sample_data.dart, app_shell.dart
•  Updated MatchesProvider to fetch user profiles for matched users
•  Cleaned up unused MockApiService dependencies

12.5 New Files Created
•  lib/services/firebase_data_service.dart — Firestore CRUD + avatar upload
•  lib/scripts/seed_firestore.dart — Auto-seed Firestore from JSON
•  lib/providers/theme_provider.dart — Dark mode theme management
•  firestore.rules — Firestore security rules
•  firebase.json — Firebase project config
•  lib/firebase_options.dart — FlutterFire config (auto-generated)

12.6 Modified Files
•  lib/main.dart — Firebase init, AuthProvider registration, seed script
•  lib/providers/auth_provider.dart — Real FirebaseAuth + Google sign-in
•  lib/providers/chat_provider.dart — Firestore real-time streams
•  lib/providers/matches_provider.dart — Fetch user profiles for matches
•  lib/screens/auth/login_screen.dart — AuthProvider integration, Google sign-in
•  lib/screens/auth/splash_screen.dart — Auth state check for routing
•  lib/screens/auth/role_selection_screen.dart — AuthProvider instead of AuthService
•  lib/screens/messages/chat_screen.dart — Real-time messages from Firestore
•  lib/screens/messages/messages_list_screen.dart — Real conversations from Firestore
•  lib/screens/profile/edit_profile_screen.dart — Image picker + upload
•  lib/screens/explore/project_details_screen.dart — Apply to Join with Firestore
•  lib/utils/app_theme.dart — Added dark theme
•  lib/screens/settings/settings_screen.dart — Dark mode toggle
•  lib/screens/home/main_shell.dart — Theme-aware background
•  lib/widgets/launchpad_bottom_nav.dart — Theme-aware colors
•  lib/models/match_model.dart — Firestore Timestamp handling
•  lib/models/message.dart — Firestore Timestamp handling
•  assets/data/projects.json — Normalized IDs to p1-p10
•  assets/data/applications.json — Normalized IDs to p1-p10
•  pubspec.yaml — Added google_sign_in, image_picker
•  web/index.html — Google Sign-in meta tag
