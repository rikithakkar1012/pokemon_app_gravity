```markdown
# Pokémon Cards App

A Flutter app that fetches and displays Pokémon cards from the Pokémon TCG API, featuring search, infinite scroll pagination, smooth transitions, and detailed card information.

## Features
- **Infinite Scroll Pagination**: Load more cards as you scroll.
- **Search**: Find Pokémon cards by name.
- **Smooth Animations**: Animated transitions between card list and details.
- **Card Details**: View card info including attacks, weaknesses, artist, and more.
- **Image Caching**: Optimized image loading with caching.

## Getting Started

### 1. Clone the repo:
```bash
git clone https://github.com/rikithakkar1012/pokemon_app_gravity.git
cd pokemon_app_gravity
```

### 2. Install dependencies:
```bash
flutter pub get
```

### 3. Run the app:
```bash
flutter run
```

## Tech Stack
- **Flutter**: UI framework
- **Dio**: API calls
- **GetX**: State management
- **GetIt**: Dependency injection
- **CachedNetworkImage**: Image caching

## Folder Structure
```text
lib/
├── core/          # Core utilities, constants, and themes
├── data/          # API & Data models
├── domain/        # Business logic & Use cases
├── presentation/  # UI & Controllers
└── main.dart      # Entry point

```

## Dependencies
flutter, dio, get, get_it, cached_network_image

Feel free to reach out if you have questions. Happy coding! 🚀