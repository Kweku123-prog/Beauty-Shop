# 💄 Beauty App

A Flutter application for discovering beauty professionals, viewing their services, and booking appointments.  
Built with **Flutter** and **Bloc** state management for a clean and scalable architecture.

---

## ✨ Features

- Browse and discover beauty professionals.
- Apply filters to find the right services.
- View detailed professional profiles with available services.
- Book appointments by selecting a time slot.
- Light/Dark theme toggle.
- Error handling with retry & shimmer loading effects.

---

## 📸 Screens

- **Discover Screen** – Browse and filter professionals.  
- **Professional Details** – View services offered by a professional.  
- **Booking Screen** – Select a service and confirm a booking slot.  

---

## 🛠️ Tech Stack

- [Flutter](https://flutter.dev/) – Cross-platform app development.
- [Bloc](https://bloclibrary.dev/) – State management.
- [Shimmer Animation](https://pub.dev/packages/shimmer_animation) – Loading placeholders.
- [Material Design](https://m3.material.io/) – UI components.

---

## 🚀 Getting Started

### Prerequisites
- Install [Flutter](https://docs.flutter.dev/get-started/install).
- Ensure you have an emulator or a connected device.

### Installation
Clone the repo:
```bash
git clone https://github.com/Kweku123-prog/Beauty-Shop.git


This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
Install dependencies:
flutter pub get
Run the app:
flutter run

This project includes unit/widget tests. Run them with:
flutter test



Assumptions

Users can browse Professionals without authentication (login will be added later).

Booking APIs are not yet integrated — booking flow is mocked locally.

Professionals have basic profile details (name, category, price) and can be filtered.

Decisions

Used BLoC for predictable state management and testability.

Chose repository + DTO/mappers structure to allow easy backend integration later.

UI kept minimal but production-style to focus on feature correctness.

Shortcuts (due to time)

Hardcoded/mock data used in place of API calls.

Error handling is simplified (only essential user-facing errors shown).