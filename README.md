# Sean's Sandwich Shop

A small Flutter demo app for counting and configuring sandwich orders. The app provides a simple UI to set sandwich quantity, choose sandwich length (six-inch or footlong), select bread type, and add order notes.

Key features
- Increment and decrement sandwich quantity with limits.
- Toggle between six-inch and footlong sandwich types.
- Choose bread from a dropdown (white, wheat, wholemeal).
- Add and display order notes.
- Lightweight, single-screen demo suitable for learning Flutter basics.

Screenshots
- Add screenshots to illustrate the app. Place images in `/assets/screenshots/` and reference them below:
  - Example:
    ![Main screen](assets/screenshots/main_screen.png)
  - If you don't have screenshots yet, run the app and capture images on device/emulator and add them to the referenced folder.

Installation and setup

Prerequisites
- Supported OS: macOS, Windows, Linux (any OS supported by Flutter).
- Flutter SDK (>= stable channel). Install from https://flutter.dev/docs/get-started/install
- Git (for cloning) and an IDE (VS Code, Android Studio) recommended.

Clone the repository
- git clone <repository-url>
- cd seansandwich_shop

Get dependencies
- flutter pub get

Run the app
- Run on an emulator or connected device:
  - flutter run
- To run in a specific device or platform:
  - flutter run -d chrome   # web
  - flutter run -d <device_id>

Build release
- Android APK:
  - flutter build apk
- iOS:
  - flutter build ios

Usage

Main flows
- Start the app to see the "Sandwich Counter" screen.
- Use the Add and Remove buttons to modify the sandwich quantity. Buttons will be disabled when the minimum (0) or maximum (configurable) is reached.
- Toggle the Switch between "six-inch" and "footlong" sandwich types.
- Use the bread dropdown to select bread type (white, wheat, wholemeal).
- Enter a note in the text field to attach to the order (e.g., "no onions"). Notes are displayed under the order summary.

Configuration options
- The OrderScreen widget accepts an optional `maxQuantity` parameter to cap the quantity. To change it, edit the instantiation in `lib/main.dart`:
  - Example: `OrderScreen(maxQuantity: 8)`

Testing
- There are no automated tests included by default.
- To run tests if you add them: `flutter test`

Project structure and important files
- lib/
  - main.dart — main application file. Implements UI, button logic, bread selection, and order display.
  - app_styles.dart — shared text styles used across the app.
- pubspec.yaml — project metadata and dependencies.
- README.md — this document.
- assets/ (optional) — add screenshots or assets here and register them in pubspec.yaml if needed.

Technologies and packages
- Flutter (Dart)
- No external pub packages are required for the current code (uses Flutter framework only).

Known issues and limitations
- Simple demo app intended for learning; not production-ready.
- No state persistence: orders and notes are lost on app restart.
- No automated tests included by default.
- UI and accessibility improvements can be added (responsive layout, keyboard focus, i18n).

Planned improvements
- Persist orders locally (shared_preferences or local DB).
- Add unit and widget tests.
- Improve layout for small/large screens and accessibility labels.
- Add CI and release workflows.

Contributing
- Contributions are welcome:
  1. Fork the repository.
  2. Create a feature branch.
  3. Open a pull request with a clear description.
- Please open issues for bugs or feature requests.

Contact
- Maintainer: Sean (update this with a real email or GitHub profile)
- GitHub: add your profile/repo link here

License
- Add your preferred license at the project root (e.g., MIT) or update README with license details.
