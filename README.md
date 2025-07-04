# TikTok Clone

A cross-platform TikTok clone built with Flutter and Firebase.

## Features

- User authentication (sign up, login, logout)
- Video upload and playback
- Like, comment, and share videos
- User profiles
- Search functionality
- Responsive UI for mobile and web

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- Android Studio or Xcode (for mobile development)

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/nhailtv/tiktok_clone.git
   cd tiktok_clone
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Configure Firebase:**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the respective directories.
   - Update `firebase_options.dart` if needed.

4. **Run the app:**
   ```sh
   flutter run
   ```

## Project Structure

- `lib/` - Main source code
  - `Controllers/` - State management and business logic
  - `Models/` - Data models
  - `Views/` - UI screens and widgets
- `android/`, `ios/`, `web/`, `linux/`, `macos/`, `windows/` - Platform-specific code

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

[MIT](LICENSE)
