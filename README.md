# LanternChat

**LanternChat** is a modern, real-time chat application built with **Flutter** and **Firebase**. It demonstrates production-ready development practices through clean, scalable architecture, advanced state management, and seamless cross-platform support (mobile + web).

The application supports **one-to-one** and **group** messaging, complete with typing indicators, message read receipts, QR code-based contact addition, conversation management (including multi-select deletion and editing), user presence, dark mode, and a fully responsive web layout with resizable panels.

This project serves as a comprehensive portfolio piece, showcasing professional Flutter development skills, iterative refactoring, and a strong focus on maintainable, testable code.

---


## Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Riverpod (with MVVM pattern)
- **Reactive Programming**: RxDart for real-time stream handling
- **Backend & Services**:
  - Firebase Authentication (Google Sign-In)
  - Firestore (conversations, messages, contacts, groups)
  - Firebase Realtime Database (typing indicators, user presence)
- **Architecture & Tools**:
  - Feature-First MVVM architecture
  - GoRouter for type-safe navigation
  - SharedPreferences for local persistence
  - FlutterFire & Firebase CLI
  - Custom theming with `ChatTheme` and `CustomTheme` extensions
- **Utilities**: Centralized `AppLogger`, responsive layout utilities, animated widgets

---

## Architecture

LanternChat employs a **Feature-First MVVM (Model-View-ViewModel)** architecture. Each feature is self-contained with its own data layer, view models, and UI components, ensuring excellent separation of concerns, testability, and scalability.


## 🤍 Key Highlights

- **Feature-First MVVM Architecture** with Riverpod for robust state management
- **Cross-platform support** — Fully responsive layout for mobile and web (resizable side panels)
- **Real-time capabilities** powered by Firestore and Firebase Realtime Database
- **Advanced chat features** — Message editing, batch deletion, read receipts, typing indicators, and user online presence
- **Modern UI/UX** — Refined color palette, enhanced dark mode, animated components, and consistent theming
- **Clean & Modular Codebase** — Extensive refactoring for modularity, separation of concerns, and scalability

---

## Features

### Real-time Messaging
- One-to-one private chats
- Group chats with multiple participants
- Real-time message streaming
- Typing indicators with animated dots
- Message read receipts (seen status with last-seen pointers)
- Message editing and deletion (individual & batch)
- Conversation selection and multi-select deletion

### Contact & Discovery
- QR code generation for your user profile
- QR code scanning to add contacts instantly
- Reciprocal contact addition with shared conversation IDs
- Live contact list with real-time updates
- User presence (online/offline status)

### User Interface & Experience
- Responsive web layout with resizable side panel
- Refined chat UI and color palette
- Dark mode support with granular theme customization
- Smooth animations and consistent design system
- Conversation search functionality

### Profile & Settings
- Google Sign-In authentication (with web support)
- Profile management and user information display
- Theme preferences (light/dark mode) persisted via SharedPreferences
- Global app lifecycle management
- Logout functionality

### Additional Capabilities
- Lazy conversation creation
- Optimized streams and data merging for performance
- Comprehensive error handling and logging via centralized `AppLogger`

---

## Project Goals

- Demonstrate professional, production-grade Flutter + Firebase integration
- Showcase clean architecture principles and iterative refactoring
- Highlight advanced state management, reactive programming, and cross-platform development
- Serve as a strong portfolio example for senior Flutter developer roles

---


### Folder Structure

```text
lib/
├─ core/                  # Shared utilities, constants, themes, routing, Firebase services, logger
│   ├─ constants/
│   ├─ firebase/
│   ├─ helpers/
│   ├─ router/            # GoRouter configuration
│   ├─ theme/             # CustomTheme, ChatTheme extensions, dark mode support
│   └─ util/
├─ features/              # Modular feature-based organization
│   ├─ auth/              # Authentication (ViewModel, providers, UI)
│   ├─ chat/              # Core messaging logic, ChatPage, bubbles, typing
│   ├─ contact/           # Contacts management and QR integration
│   ├─ conversation/      # Conversation models, services, MVVM
│   ├─ groups/            # Group chat creation and management
│   ├─ home/              # Responsive HomePage with web support
│   ├─ profile/           # Profile screens and management
│   ├─ qr/                # QR code generation and scanning
│   └─ settings/          # Settings with MVVM implementation
├─ models/                # Data models (AppUser, Contact, Message, Conversation, etc.)
└─ shared/                # Reusable widgets and UI components