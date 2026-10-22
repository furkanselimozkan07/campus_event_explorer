# Campus Event Explorer

**BIM493 – Mobile Programming I | Assignment #1**

Campus Event Explorer is a Flutter mobile application that allows students to discover fictional campus events, save favorites, and manage event participation. Event data and images are bundled locally. The application does not require an account, database, backend, internet connection, or third-party API.

## Team Members and Contributions

| Student | Full Name | Student ID | Contribution |
|---|---|---|---|
| Student 1 | Ahmet Enes Şahan | 26779932038 | Event model and sample data; Explore screen and event cards; title search and category filtering; Favorites functionality and shared screen state. |
| Student 2 | Furkan Selim Özkan | 12343613014 | Event Details and enlarged-image screens; join/cancel confirmation dialogs; capacity and participation logic; local assets and font integration; testing and documentation. |

**Joint work:** Interface review, emulator testing, troubleshooting, code analysis, and final project verification.

## Development Environment

The project was developed using Flutter 3.47.6 on the Stable channel. The following version information was obtained from the development machine:

```text
Flutter 3.47.6 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 5fc346839b (2 weeks ago) • 2026-09-30 15:02:49 -0700
Engine • hash b8c8d3d8d5d0095127057f8a29ca8cc53da2167c (revision 692136cb65) (16 days ago) • 2026-09-30 00:56:59.000Z
Tools • Dart 3.13.5 • DevTools 2.60.0
```

Development and testing were performed using Visual Studio Code, Android Studio, and a Pixel 7 Android emulator running Android 17 (API 37).

## Requirements and Running the App

1. Install Flutter **3.47.6 Stable** and Android Studio with the Android SDK.
2. Download or clone the complete Flutter project.
3. Open a terminal in the project root directory (the folder containing `pubspec.yaml`).
4. Run:

```bash
flutter pub get
flutter devices
flutter run
```

If multiple devices are available, run `flutter run -d <device-id>` using an ID from `flutter devices`. The emulator used during development was identified as `emulator-5554`; the ID may differ on another computer.

To check the project, run:

```bash
flutter analyze
flutter test
```

The source project is required for submission; an APK is optional.

## Implemented Features

- **Event dataset:** Eight fictional events across Technology, Arts, and Sports, each with a unique ID, title, category, date/time, venue, description, local image, total capacity, and initial availability.
- **Availability edge cases:** One event starts full, and another starts with exactly one available place.
- **Explore:** Scrollable event cards with images, category, date/time, venue, availability, favorite controls, and navigation to details.
- **Search and filters:** Case-insensitive title search that ignores surrounding spaces, an All option and three category filters, matching-event counts, and an empty state. The same search and category settings apply across all three tabs.
- **Event Details:** Separate screen with full event information, favorite control, participation actions, and an enlarged image viewer opened by double-tapping the image.
- **Favorites:** Favorite and unfavorite actions from cards and details, reflected across screens during the same app session.
- **My Events:** A dedicated view for joined events, with a total joined-event count.
- **Participation:** Join and cancel confirmation dialogs; capacity updates only after confirmation; prevention of duplicate joins; disabled joining for full events; and cancellation for students who joined the last available place.
- **Interface and state:** Flutter Material widgets, reusable `StatelessWidget` components, `StatefulWidget`, and in-memory state updates using `setState()`.
- **Offline assets:** Bundled category illustrations, Lato fonts, and Material icons.

## Project Structure

```text
lib/
  main.dart
  models/event.dart
  data/event_data.dart
  utils/event_format.dart
  widgets/event_card.dart
  screens/home_screen.dart
  screens/event_details_screen.dart
  screens/image_viewer_screen.dart
assets/
  images/technology.png
  images/arts.png
  images/sports.png
  fonts/Lato-Regular.ttf
  fonts/Lato-Bold.ttf
licenses/LATO_OFL_LICENSE.txt
docs/MANUAL_TESTS.md
test/widget_test.dart
screenshots/
  01_explore.png
  02_details.png
  03_favorites.png
  04_my_events.png
```

## Testing and Verification

The following results were obtained on the development machine:

| Check | Result |
|---|---|
| `flutter --version` | Flutter **3.47.6 Stable** |
| `flutter analyze` | **No issues found!** |
| `flutter test` | **2 tests passed** (`All tests passed!`) |

### Manual Testing

The following functionality was tested on a Pixel 7 Android emulator:

- Event browsing, title search, and category filtering.
- Empty-search feedback.
- Adding and removing favorites.
- Event details and double-tap image enlargement.
- Joining events and decreasing available places.
- Cancelling participation and restoring available places.
- Preventing participation in full events.
- Updating Favorites and My Events during the same session.
- Dismissing the on-screen keyboard from the search field.

### Checklist of Required Cases

- [x] **Full event:** *Acoustic Music Night* is labelled **Full** and its Join button is disabled.
- [x] **Last place:** joining *Flutter Basics Workshop* (1 place) makes it 0; the student can still cancel.
- [x] **Join dialog:** *No* or tapping outside leaves available places unchanged; *Yes* joins once and shows feedback.
- [x] **Cancel dialog:** *No* keeps the event joined; *Yes* removes it from My Events and restores one place.
- [x] **Empty search:** a non-matching title shows a readable empty state, and the search can be cleared.
- [x] **Offline:** the app works with networking disabled.

The full step-by-step checklist is in `docs/MANUAL_TESTS.md`.

### Required Screenshots

Screenshots captured from the Android emulator are available in `screenshots/`:

- [Explore](screenshots/01_explore.png)
- [Event Details](screenshots/02_details.png)
- [Favorites](screenshots/03_favorites.png)
- [My Events](screenshots/04_my_events.png)

## Asset Credits and Licenses

- **Category illustrations (Technology, Arts, Sports):** Original illustrations created for this project and bundled with the application. No external photographs are used.
- **Lato Regular and Bold:** Copyright 2010–2011 Łukasz Dziedzic. Licensed under the SIL Open Font License 1.1; see `licenses/LATO_OFL_LICENSE.txt`.
- **Icons:** Flutter's bundled Material Icons.

## Known Limitations

- Favorites and participation are kept in memory and may reset after the application is fully restarted, as permitted by the assignment.
- Events are fictional; joining does not create a real reservation.
- Login, push notifications, GPS, real-time server updates, and cloud synchronization are not included because they are outside the assignment scope.
