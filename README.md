# 📱 Aplikasi Dicoding Event

Aplikasi Flutter yang menampilkan daftar event dari API publik.  
Proyek ini dibuat sebagai latihan dalam mengonsumsi API, pengelolaan tema (dark/light mode), dan navigasi menggunakan `BottomNavigationBar`.

---

## ✨ Fitur Utama

- 🗓️ Menampilkan **Upcoming Event** dan **Finished Event**
- 🔍 Pencarian event berdasarkan keyword
- 🌙 **Toggle Dark Mode / Light Mode**, dan preferensi tersimpan di local storage
- 📄 Halaman **Detail Event**

---

## 🛠️ Teknologi & Package

- **Flutter** & **Dart**
- [`http`](https://pub.dev/packages/http) – untuk konsumsi API
- [`shared_preferences`](https://pub.dev/packages/shared_preferences) – menyimpan preferensi dark mode
- **StatefulWidget** – untuk pengelolaan state sederhana
- **BottomNavigationBar** – navigasi antar halaman

---

## 🗂️ Struktur Folder

```plaintext
lib/
├── models/
│   └── event.dart
│
├── screens/
│   ├── event_detail.dart
│   ├── finished_event.dart
│   ├── main_page.dart
│   ├── search_event.dart
│   ├── setting.dart
│   └── upcoming_event.dart
│
├── services/
│   ├── finished_event_service.dart
│   ├── search_event_service.dart
│   └── upcoming_event_service.dart
│
└── main.dart
```