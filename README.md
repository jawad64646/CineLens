# 🎬 CineLens

> **Discover. Watch. Repeat.**
>
> A modern cross-platform movie and TV discovery application built with **Flutter**, featuring JWT authentication, trending content, in-app trailer playback, persistent sessions, and a REST API backend deployed on **Railway**.

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.13%2B-02569B?logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-3.13%2B-0175C2?logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-orange" alt="Clean Architecture">
  <img src="https://img.shields.io/badge/State-BLoC%20%2F%20Cubit-7B1FA2" alt="BLoC / Cubit">
  <img src="https://img.shields.io/badge/Backend-Express.js-000000?logo=express&logoColor=white" alt="Express.js">
  <img src="https://img.shields.io/badge/Deploy-Railway-0B0D0E?logo=railway&logoColor=white" alt="Railway">
</p>

---

## ✨ Overview

**CineLens** is a Flutter-based movie and TV discovery application focused on delivering a smooth and cinematic browsing experience.

Users can discover trending movies and TV shows, explore currently playing content, watch trailers directly inside the application, and maintain an authenticated session between launches.

The application communicates with a **separate Express.js REST API**, which is already **deployed and hosted on Railway**.

### Highlights

* 🔐 JWT authentication with persistent sessions
* 🎬 Trending movies and Now Playing
* 📺 Trending and popular TV shows
* ▶️ In-app YouTube trailer playback
* 🎯 Similar and recommended content
* ⚡ BLoC / Cubit state management
* 🌐 REST API integration with Dio
* 🔒 Secure JWT persistence
* 🛡️ Centralized error handling
* 📱 Android, iOS, and Web support
* 🎨 Modern cinematic UI

---

# 🏗️ Architecture

CineLens follows **Clean Architecture** with clear separation between the application's **Presentation, Domain, and Data layers**.

The **Presentation layer is organized by feature**, with each feature containing its own pages, widgets, and BLoC/Cubit state management.

```text
┌─────────────────────────────────────────────┐
│              PRESENTATION                   │
│                                             │
│  Feature-based                              │
│                                             │
│  ┌─────────┐  ┌─────────┐  ┌────────────┐  │
│  │  Auth   │  │  Home   │  │   Watch    │  │
│  │         │  │         │  │            │  │
│  │ Pages   │  │ Pages   │  │ Pages      │  │
│  │ Widgets │  │ Widgets │  │ Widgets    │  │
│  │ BLoC    │  │ Cubits  │  │ BLoC/Cubit │  │
│  └─────────┘  └─────────┘  └────────────┘  │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│                  DOMAIN                     │
│                                             │
│        Entities • Use Cases • Contracts     │
│                                             │
│          Framework / UI independent         │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────┐
│                   DATA                      │
│                                             │
│       Repository Implementations            │
│       Models • Remote API • Storage         │
└──────────────────────┬──────────────────────┘
                       │
                       ▼
                Express.js REST API
                       │
                       ▼
                    Railway
```

### 📱 Presentation Layer

The Presentation layer follows a **feature-based structure**.

Each feature groups the UI and its presentation state together.

```text
presentation/
├── auth/
│   ├── pages/
│   ├── widgets/
│   └── bloc/
│
├── home/
│   ├── pages/
│   ├── widgets/
│   └── bloc/
│
└── watch/
    ├── pages/
    ├── widgets/
    └── bloc/
```

This keeps related UI components and state management close to the feature they belong to.

### Domain Layer

The Domain layer contains the application's core business logic and remains independent from Flutter-specific UI concerns.

It is responsible for:

* Entities
* Use cases
* Repository contracts

### Data Layer

The Data layer handles communication and persistence.

It is responsible for:

* API models
* Repository implementations
* Dio requests
* Remote data sources
* Secure storage
* Data transformation

---

# 📁 Project Structure

```text
lib/
├── core/
│   ├── constants/
│   ├── error/
│   ├── network/
│   ├── storage/
│   └── theme/
│
├── features/
│   ├── auth/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── widgets/
│   │       └── bloc/
│   │
│   ├── home/
│   │   └── presentation/
│   │       ├── pages/
│   │       ├── widgets/
│   │       └── bloc/
│   │
│   └── watch/
│       └── presentation/
│           ├── pages/
│           ├── widgets/
│           └── bloc/
│
└── main.dart
```

### Core

Shared application infrastructure:

* API constants
* Dio configuration
* Network interceptors
* Error handling
* Secure storage
* Theme and typography

### Features

The main presentation features are:

| Feature   | Description                                        |
| --------- | -------------------------------------------------- |
| **Auth**  | Sign In, Sign Up, authentication state             |
| **Home**  | Trending movies, Now Playing, TV discovery         |
| **Watch** | Trailers, details, similar and recommended content |

---

# ⚡ State Management

CineLens uses **BLoC / Cubit** for presentation state management.

API operations follow predictable state transitions:

```text
Initial
   │
   ▼
Loading
   │
   ├──────────► Error
   │
   ▼
Loaded
```

This keeps widgets focused on UI while BLoCs/Cubits manage presentation state and coordinate application logic.

---

# 🔐 Authentication

CineLens uses **JWT authentication** with persistent secure storage.

```text
Sign In
   │
   ▼
POST /auth/signin
   │
   ▼
JWT Token
   │
   ▼
flutter_secure_storage
   │
   ▼
Restore Session
   │
   ▼
Authenticated App
```

The application:

* Stores the JWT securely
* Restores authentication on launch
* Automatically adds the Bearer token to API requests
* Handles authentication failures centrally

---

# 🌐 Networking

The application uses **Dio** for REST API communication.

A custom interceptor handles authenticated requests and common networking concerns.

### Responsibilities

* HTTP requests
* JWT Bearer authentication
* Request/response logging
* Dio exception handling
* Error normalization

Example:

```http
Authorization: Bearer <JWT_TOKEN>
```

---

# ☁️ Backend

CineLens communicates with a **separate Express.js REST API**.

The backend is **already deployed on Railway**.

No local Express.js server is required when using the deployed API.

```text
┌──────────────────┐
│  Flutter Client  │
└────────┬─────────┘
         │
         │ HTTPS / REST
         ▼
┌──────────────────┐
│  Express.js API  │
└────────┬─────────┘
         │
         ▼
┌──────────────────┐
│     Railway      │
│    Deployment    │
└──────────────────┘
```

The backend provides:

* Authentication
* JWT handling
* Movie data
* TV show data
* Trending content
* Now Playing content
* Trailer information
* Recommendations

> **Note:** The Express.js backend is maintained separately from this Flutter repository.

---

# 📡 API

| Method | Endpoint             | Description        |
| ------ | -------------------- | ------------------ |
| `POST` | `/auth/signup`       | Register user      |
| `POST` | `/auth/signin`       | Authenticate user  |
| `GET`  | `/movie/trending`    | Trending movies    |
| `GET`  | `/movie/nowplaying`  | Now Playing movies |
| `GET`  | `/movie/:id/trailer` | Movie trailer      |
| `GET`  | `/tv/trending`       | Trending TV shows  |
| `GET`  | `/tv/popular`        | Popular TV shows   |
| `GET`  | `/tv/:id/trailers`   | TV trailers        |

---

# 🧰 Tech Stack

| Technology                    | Purpose                       |
| ----------------------------- | ----------------------------- |
| **Flutter / Dart**            | Cross-platform application    |
| **BLoC / Cubit**              | Presentation state management |
| **Dio**                       | REST API networking           |
| **GetIt**                     | Dependency injection          |
| **Dartz**                     | Functional error handling     |
| **Flutter Secure Storage**    | JWT persistence               |
| **Flutter SVG**               | SVG rendering                 |
| **Fan Carousel Image Slider** | Trending movie carousel       |
| **YouTube Player IFrame**     | Trailer playback              |
| **Intl**                      | Date and number formatting    |
| **Rubik**                     | Typography                    |
| **Express.js**                | REST API backend              |
| **JWT**                       | Authentication                |
| **Railway**                   | Backend deployment            |

---

# 🛡️ Error Handling

CineLens uses `Either<Failure, T>` from `dartz` to represent successful and failed operations.

```dart
Future<Either<Failure, List<Movie>>> getTrendingMovies();
```

Results can be handled by the presentation layer:

```dart
result.fold(
  (failure) => ErrorMessageMixin.show(
    context,
    failure.message,
  ),
  (movies) => emit(
    MoviesLoaded(movies),
  ),
);
```

This provides consistent handling for:

* Network failures
* API errors
* Authentication errors
* Dio exceptions
* User-facing error messages

---

# 🚀 Getting Started

## Requirements

* Flutter `3.13+`
* Dart `3.13+`
* Internet connection

## Installation

```bash
git clone https://github.com/jawad64646/CineLens.git
cd CineLens
flutter pub get
```


```bash
flutter run
```

For Web:

```bash
flutter run -d chrome
```

---
# 🤝 Contributing

Contributions are welcome and appreciated! If you'd like to improve CineLens, feel free to contribute.

### How to Contribute

1. Fork the repository.
2. Create a new branch:

```bash
git checkout -b feature/your-feature
```

3. Make your changes and keep the code clean and consistent with the existing architecture.
4. Run formatting, analysis, and tests:

```bash
dart format .
flutter analyze
flutter test
```

5. Commit your changes with a clear message:

```bash
git commit -m "feat: add your feature"
```

6. Push your branch:

```bash
git push origin feature/your-feature
```

7. Open a Pull Request and describe the changes you've made.

### Contribution Guidelines

* Follow the existing **Clean Architecture** structure.
* Keep the **Presentation layer feature-based**, with related pages, widgets, and BLoC/Cubit together.
* Use clear and meaningful names.
* Keep widgets focused and reusable where appropriate.
* Handle errors consistently using the existing failure-handling approach.
* Avoid unnecessary dependencies.
* Make sure the project passes `flutter analyze` and `flutter test` before submitting a Pull Request.

### 🐛 Bug Reports & Feature Requests

If you find a bug or have an idea for improving CineLens, please open an issue with enough detail to reproduce the problem or understand the proposed feature.

# 📱 Platform Support

CineLens supports:

* 🤖 Android
* 🍎 iOS
* 🌐 Web

The UI is designed with responsive layouts to provide a consistent experience across different screen sizes.

---

# 📸 Screenshots

Add real application screenshots to:

```text
screenshots/
├── splash.png
├── signin.png
├── signup.png
├── home.png
├── movie-details.png
├── tv-details.png
└── trailer.png
```

Recommended README showcase:

|   Authentication  |         Home         |      Watch     |
| :---------------: | :------------------: | :------------: |
| Sign In / Sign Up | Trending & Discovery | Trailer Player |

---

# 🧪 Development

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Format the project:

```bash
dart format .
```

---

# 📄 License

This project is licensed under the **MIT License**.

See the [`LICENSE`](LICENSE) file for details.

---

# 👨‍💻 Author

**Jawad**

Flutter Developer

* **GitHub:** [github.com/jawad64646](https://github.com/jawad64646)
* **LinkedIn:** [linkedin.com/in/jawad-40434841b](https://www.linkedin.com/in/jawad-40434841b/)

---

<div align="center">

### 🎬 CineLens

**Discover. Watch. Repeat.**

Built with ❤️ using **Flutter**

Backend powered by **Express.js + Railway**

</div>
