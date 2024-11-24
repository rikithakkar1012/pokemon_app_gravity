# Pokémon Cards App

A Flutter app that fetches and displays Pokémon cards from the [Pokémon TCG API](https://pokemontcg.io/), with features like search, infinite scroll pagination, smooth transitions, and detailed card information.

## Features
- **Infinite Scroll Pagination**: Load more cards as you scroll.
- **Search**: Find Pokémon cards by name.
- **Smooth Animations**: Animated transitions between card list and details.
- **Card Details**: View card info including attacks, weaknesses, artist, and more.
- **Image Caching**: Optimized image loading with caching.

## Getting Started

### 1. Clone the repo:
```bash
git clone https://github.com/your-username/pokemon-cards-app.git
cd pokemon-cards-app

### 2. Install dependencies:
```bash
flutter pub get

### 3. Run the app:
```bash
Copy code
flutter run

Tech Stack

Flutter: UI framework
Dio: API calls
GetX: State management
GetIt: Dependency injection
CachedNetworkImage: Image caching
flutter_staggered_grid_view: Grid layout

Folder Structure

lib/
├── data/          # API & Data models
├── domain/        # Business logic & Use cases
├── presentation/  # UI & Controllers
└── main.dart      # Entry point

Dependencies
flutter, dio, get, get_it, cached_network_image, flutter_staggered_grid_view

Feel free to reach out if you have questions. Happy coding!


### Key Changes:
1. **Brevity**: Shortened explanations and removed unnecessary details.
2. **Simplified Structure**: Focused only on essential features, setup, and dependencies.
3. **Professional Tone**: Kept it clean and to the point, suitable for an interview task.
