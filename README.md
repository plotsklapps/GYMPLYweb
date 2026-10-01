# GYMPLY Web 🏋️‍♂️

Official website for **GYMPLY** — The Minimalist, Privacy-First, Offline Workout Tracker for Android (and coming soon to iOS).

Live at **[gymply.app](https://gymply.app)**

---

## 🌟 About GYMPLY

GYMPLY is designed for fitness enthusiasts who value simplicity, complete privacy, and zero bloat. No accounts, no paywalls, no internet connection required, and 0% ads.

This repository contains the full source code for the **[gymply.app](https://gymply.app)** promotional web application built with **Flutter Web**.

---

## 🚀 Core Web Features

The website is structured as a fluid, full-screen vertical page scroller (`MainScroller`) featuring 5 interactive sections:

1. **Hero Landing Page (`ScreenOne`)**: Bold typography (`Bebas Neue` & `Teko`), core value highlights, and instant download badges for Google Play and GitHub APK.
2. **Interactive Showcase (`ScreenTwo`)**: Animated stack of dynamic exercise cards representing GYMPLY's database of **4,000+ exercises**.
3. **Pillars Grid (`ScreenThree`)**: Clean feature breakdown covering 100% privacy, zero ads/subscriptions, offline-first capabilities, and Nostr protocol integration.
4. **App Experience (`ScreenFour`)**: Modern Material 3 `CarouselView` displaying high-resolution app screenshots.
5. **User Reviews & Responses (`ScreenFive`)**: 5-star Google Play user reviews accompanied by official developer responses and custom avatar badges.
6. **Work In Progress iOS Badge**: Interactive App Store badge featuring street-construction hazard tape and an informative dialog for upcoming iOS availability.

---

## 🎨 Design System & Styling

- **Color Palette**:
  - Background: Black (`#000000`) & Dark Container (`#1A1A1A`)
  - Primary Accent: Warm Gold (`#FCB075`)
  - Text: Crisp Off-White (`#DEDEDE`)
- **Typography**:
  - Headlines & Titles: `Bebas Neue`
  - Body & Text: `Teko`
- **Animations**: Fluid entrance and scale effects powered by `flutter_animate`.
- **Navigation**: Custom gesture & pointer-wheel vertical snapping via `PageView`.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter Web](https://flutter.dev/multi-platform/web)
- **UI Toolkit**: Material 3 Design
- **Animations**: `flutter_animate`
- **Analytics**: `firebase_analytics` & `firebase_core`
- **Link Handling**: `url_launcher`
- **Code Quality**: `very_good_analysis` (Strict linting & formatting)

---

## 💻 Local Development

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`>=3.13.1 <4.0.0`)
- Google Chrome or any modern web browser

### Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/plotsklapps/GYMPLYweb.git
   cd GYMPLYweb
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run locally in Chrome**:
   ```bash
   flutter run -d chrome
   ```

4. **Analyze code**:
   ```bash
   flutter analyze
   ```

### Building for Production

To compile the web release build for hosting on Firebase / Vercel / Netlify:

```bash
flutter build web --release
```

The output will be generated in `build/web/`.

---

## 🔗 Official Links

- **Website**: [gymply.app](https://gymply.app)
- **App Source Code**: [plotsklapps/GYMPLY](https://github.com/plotsklapps/GYMPLY)
- **Google Play Store**: [GYMPLY on Play Store](https://play.google.com/store/apps/details?id=dev.plotsklapps.gymply)
- **Latest Android APK**: [GitHub Releases](https://github.com/plotsklapps/GYMPLY/releases/latest)

---

## 📄 License

GYMPLY Web is open source software released under the [MIT License](LICENSE).
