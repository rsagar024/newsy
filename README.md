# 📰 Newsy App — Flutter News Application

Newsy is a sleek and responsive Flutter application that delivers the latest news across various categories. It provides a smooth user experience with organized dashboards, in-depth article views, and an efficient search system backed by recent history tracking.

---

## ✨ Features

- 🏠 **Dashboard** with trending and latest news
- 🗂️ **Category filters** (Business, Entertainment, Health, etc.)
- 🔍 **Search with debouncing & history**
- 📰 **Detailed article view**
- 🔄 **Pull-to-refresh** support
- 📱 **Responsive UI** for all screen sizes

---

## 🛠️ Tech Stack

| Tool                | Purpose                    |
|---------------------|----------------------------|
| Flutter (v3.19.5)   | Framework                  |
| Dart (v3.3.0)       | Language                   |
| BLoC                | State management           |
| Dio                 | API client                 |
| GetIt               | Dependency injection       |
| Shared Preferences  | Local storage              |
| Url Launcher        | Open links externally      |

---

## 🚀 Getting Started

### 🔧 Prerequisites

- Flutter SDK (v3.22.3)
- Dart SDK (v3.3.0+)
- Android Studio / Xcode / Visual Studio Code
- Git CLI

### ⚙️ Installation

```bash
git clone https://github.com/rsagar024/newsy.git
cd newsy
flutter pub get
```

### ▶️ Run the App

```bash
flutter run
```

> 👉 Get your API key at [NewsAPI.org](https://newsapi.org)

---

## 🧠 Design Decisions

### 🔄 BLoC for State Management

- Clear logic separation
- Predictable state handling
- Scalable for new features
- Easy to test

### 🧱 Modular Structure

- Organized by feature
- Easier maintenance
- Scales well with team collaboration

### 🔍 Search Logic

- Debounced input (500ms)
- Stores recent queries locally
- Smooth loading UX

### ⚠️ Error Handling

- Friendly error screens
- Retry buttons
- Handles broken images & empty responses

---

## 🧩 Development Challenges

| Challenge               | Solution                                           |
|-------------------------|----------------------------------------------------|
| API Rate Limiting       | Caching & optimized API usage                      |
| Broken Image URLs       | Placeholders for missing images                    |
| High-frequency Searches | Debounce logic (900ms) to reduce API hits         |
| Persistent State        | Global state managed using BLoC pattern            |

---

## 🐞 Known Issues & 🔧 Future Improvements

### 🚧 Current Limitations

- Free NewsAPI plan: 100 requests/day
- No offline news caching
- Basic bookmarking only

### 📌 Planned Enhancements

- ✅ User authentication
- 🌗 Dark/Light theme support
- 🔔 Push notifications
- 📤 Share articles to social platforms
- 🧪 Add complete testing suite

---

## 📸 Screenshots
 
&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;**Dashboard** &emsp;&emsp;&emsp;&emsp;&emsp;|&emsp;&emsp;&emsp;&emsp;&emsp; **Search** &emsp;&emsp;&emsp;&emsp;&emsp;|&emsp;&emsp;&emsp;&emsp;&emsp; **Article Details**
<p align="center">
    <img src="screenshots/dashboard.jpeg" alt="Dashboard" width="250"/>
    <img src="screenshots/search.jpeg" alt="Search" width="250"/>
    <img src="screenshots/details.jpeg" alt="Details" width="250"/>
</p>

---

## 🤝 Contribution Guide

We welcome contributions!

1. Fork the repo
2. Create a new branch: `git checkout -b feature/your-feature-name`
3. Make your changes and commit: `git commit -m "Add: your message"`
4. Push to GitHub: `git push origin feature/your-feature-name`
5. Open a pull request 🚀

## 🙏 Acknowledgements

- [NewsAPI.org](https://newsapi.org) for providing the news data
- Flutter Community for open-source inspiration
