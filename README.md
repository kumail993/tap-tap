tap_task – Flutter Web Project

A modern Flutter Web application built with clean architecture, feature-based modules, reusable widgets, BLoC state management, and Supabase integration.
This is a test/demo project but structured for real-world scalability.

🚀 How to Run the Project (Flutter Web)
1. Enable Flutter Web
flutter config --enable-web

2. Install Dependencies
flutter pub get

3. Run the App
flutter run -d chrome

4. Build for Web Release
flutter build web

📁 Project Structure

The project uses a clean, modular folder structure:

lib/
│
├── config/
│   ├── constants/
│   ├── routes/
│   ├── supabase/
│   ├── theme/
│
├── core/
│   ├── functions/
│   ├── imports/
│   ├── mocks/
│   ├── widgets/
│
├── features/
│   ├── authentication/
│   ├── dashboard/
│   ├── ... (future modules)
│
└── main.dart

📦 1. config/ – Global Application Configuration

Contains all global-level definitions and setup files.

constants/

Shared design system values:

app_colors.dart

app_textstyles.dart

routes/

Central routing setup using GoRouter:

app_routes.dart

supabase/

Supabase initialization & client setup:

supabase_config.dart

theme/

Global themes + light/dark mode using Cubit:

app_theme.dart

theme_cubit.dart

⚙️ 2. core/ – Shared Core Utilities & Widgets

Reusable code accessible across all features.

functions/

Utility functions:

supabase_signout.dart

imports/

Common export file:

common_imports.dart

mocks/

Mock API/data for test environment:

mocks.dart

widgets/

Global reusable widgets:

custom_appbar.dart

custom_button.dart

custom_searchfield.dart

custom_skeleton.dart

custom_text.dart

custom_textfield.dart

layout.dart

sizedbox.dart

These components create a unified UI across the app.

🧩 3. features/ – Feature-Based Modules

Each feature is structured independently for scalability:

bloc/
repository/
views/
widgets/
models/

Example Modules
Authentication

Includes:

Auth-related BLoC

Login/Signup screens

Repositories

Widgets

Data models

Dashboard

Includes:

Dashboard UI

Components/widgets

State management (Bloc)

API data handling

This structure keeps every feature isolated and maintainable.

🏁 Entry Point – main.dart

Initializes routing

Applies app theme

Sets up Supabase

Launches the Flutter Web app

📸 Folder Screenshot

A screenshot of the project structure is attached above and reflects the exact folder organization described here.

✅ Summary

This Flutter Web project includes:

Clean, scalable architecture

Feature-based organization

Reusable global widgets

GoRouter for navigation

Supabase backend integration

Light/Dark theme support

Modular BLoC state management