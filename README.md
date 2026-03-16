# LanternChat

**LanternChat** is a **real-time chat application** built with **Flutter** and **Firebase**, designed to showcase clean architecture, professional coding practices, and advanced Flutter/Firebase integrations.

It supports **one-to-one chats, group chats, QR code sharing**, and includes **typing indicators, message seen status**, and **profile settings**. This project is a portfolio-focused application to demonstrate practical, production-ready Flutter development skills.

---

## Features

- **Real-time Chat**
  - One-to-one private messaging
  - Group chats with multiple participants

- **Status & Interactions**
  - Typing indicators
  - Message seen status

- **QR Code Integration**
  - Generate a unique QR code for your user ID
  - Scan QR codes to add new contacts

- **Contacts & Profile Management**
  - Contact list with live updates
  - Profile settings (update info & logout)

- **Settings & Personalization**
  - Basic user profile management
  - Logout functionality

- **Clean Architecture & Scalability**
  - Feature-based folder structure
  - MVVM pattern with Riverpod for state management
  - Reactive streams with RxDart for real-time updates

---

## Project Goals

- Demonstrate professional Flutter + Firebase integration
- Showcase clean, modular, and maintainable code
- Highlight reactive programming with RxDart

---

## Tech Stack

- **Framework**: Flutter (Dart)
- **State Management**: Riverpod
- **Reactive Streams**: RxDart
- **Backend**: Firebase
  - Firebase Authentication
  - Firestore (for real-time chat & group data)
- **Tools**:
  - FlutterFire CLI
  - Firebase CLI

---

## Project Architecture

LanternChat follows a **Feature-First MVVM architecture**, ensuring a **clean separation of concerns** and **scalable, maintainable code**.

**Folder Structure:**

```text
lib/
├─ core/             # Shared utilities, constants, themes, routing, and Firebase services
│  ├─ constants/     
│  ├─ firebase/      
│  ├─ helpers/       
│  ├─ router/        
│  ├─ theme/         
│  └─ util/          
├─ features/         # Each feature has its own module with data, provider, and UI
│  ├─ auth/          # Authentication logic & screens
│  ├─ chat/          # One-to-one and group chat logic, streams, and screens
│  ├─ contact/       # Contacts management
│  ├─ conversation/  # Conversation model & helpers
│  ├─ home/          # Home page / dashboard
│  ├─ profile/       # Profile screens & logic
│  ├─ qr/            # QR code generation & scanning
│  └─ settings/      # Settings & logout
├─ models/           # Data models (User, Contact, Conversation, Group)
└─ shared/           # Shared widgets & UI components