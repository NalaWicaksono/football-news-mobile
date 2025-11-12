## Football News — Copilot Instructions

Quick, actionable guidance for AI coding agents working on this Flutter app.

- Project type: Flutter mobile app (Dart). Root entry: `lib/main.dart`.
- Major UI areas: `lib/screens/` (menu, login, register, news list, news form).
- Reusable widgets: `lib/widgets/` (drawer, news cards).
- Data model: `lib/models/news_entry.dart` — JSON <-> NewsEntry mapping used throughout.

Architecture & data flow (short):
- The app provides a top-level `Provider` (in `main.dart`) exposing `CookieRequest` (from `pbp_django_auth`). Network calls use that request object.
- Backend: Django API assumed at `http://localhost:8000/`. Common endpoints used in code:
  - `GET http://localhost:8000/json/` — list of news entries (used in `news_entry_list.dart`).
  - `POST http://localhost:8000/auth/login/` — login (used in `login.dart`).
  - `POST http://localhost:8000/auth/register/` — register (used in `register.dart`).
  - `http://localhost:8000/proxy-image/?url=<img_url>` — proxied image access used by `news_entry_card.dart`.

Platform notes (must be explicit):
- When running on Android emulator, use `10.0.2.2` instead of `localhost` to reach the host machine. Several TODOs in the code remind about this.
- Image loading uses `Image.network` with an `errorBuilder` fallback — preserve that pattern when editing visuals.

Conventions & patterns to follow:
- Keep `CookieRequest` usage via the provider: fetch it with `final request = context.watch<CookieRequest>();` before network calls.
- Localhost endpoint strings are inlined in multiple files; if changing base URL, update all usages (`login.dart`, `register.dart`, `news_entry_list.dart`, `news_entry_card.dart`).
- Navigation uses `Navigator.push`, `pushReplacement`, and `MaterialPageRoute` directly (simple routing, not a package). Mirror this style for consistency.
- Forms use `GlobalKey<FormState>()` and local `setState` for field updates (no form library).

Build / run / test commands (Windows / PowerShell):
- Install deps: `flutter pub get`
- Run app: `flutter run` (or pick an emulator/device from your IDE)
- Build APK: `flutter build apk --release`
- Run widget tests: `flutter test` (tests live under `test/`)

Editing guidance for AI edits:
- Small UI changes are safe; avoid altering global state management or replacing the `Provider` pattern without a migration plan.
- If you change backend endpoints, update all strings and mention Android emulator `10.0.2.2` substitution in comments.
- Keep network error handling — many callers expect JSON lists or maps; preserve null checks and `FutureBuilder` usage.

Key files to reference when making changes:
- `lib/main.dart` — app entry and `CookieRequest` provider
- `lib/models/news_entry.dart` — canonical JSON mapping
- `lib/screens/news_entry_list.dart` and `lib/widgets/news_entry_card.dart` — list + card rendering and network fetch example
- `lib/screens/login.dart`, `lib/screens/register.dart` — authentication flow examples

If anything in this summary is unclear or you want more specific examples (e.g., a safe refactor plan to centralize backend URLs), tell me which area and I will expand or update this file.
