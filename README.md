# 🏝️ MyMelaka – Melaka Tour Booking App (Flutter)

**MyMelaka** is a mobile app developed using **Flutter**, designed to help users explore and book tourism packages around Melaka, Malaysia. It features user-friendly interfaces for both **users** and **admins**, with guest access available as well.

---

## 🎯 Project Purpose

This project was built as part of a learning journey or coursework, aiming to simulate a real-world mobile app for booking and managing tour packages. It demonstrates key Flutter concepts like routing, local storage, and user roles.

---

## 👥 User Roles

### 👤 Guest
- View tour packages
- Read user ratings & feedback

### 🙍 User
- Register and login/logout
- View available tour packages
- Submit and view ratings
- Book packages
- View booking history
- View & edit profile
- Change password

### 👨‍💼 Admin
- Login/logout
- View list of registered users and their details
- View list of all bookings/orders
- View and manage own profile

---

## ✨ Core Features

| Feature                   | Guest | User | Admin |
|---------------------------|:-----:|:----:|:-----:|
| View packages             | ✅    | ✅   |       |
| View ratings              | ✅    | ✅   |       |
| Give ratings              |       | ✅   |       |
| Book packages             |       | ✅   |       |
| View booking history      |       | ✅   |       |
| Manage profile            |       | ✅   | ✅    |
| Change password           |       | ✅   |       |
| View list of users        |       |      | ✅    |
| View list of bookings     |       |      | ✅    |
| Register & login/logout   |       | ✅   | ✅    |

---

## 🛠️ Technologies Used

- **Flutter** (Dart)
- **SQLite** (local database)
- **Shared Preferences** (for storing login sessions)
- **Material Design** + Custom UI
- **VS Code** / **Android Studio**

---

## 🚀 Installation & Run

1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/mymelaka.git
   cd mymelaka
