# 🎬 Movie Ticket Booking App

A modern Flutter application to browse movies, view details, pick show timings, and book tickets seamlessly — inspired by BookMyShow and Paytm Movies.

![Movie Banner Placeholder](assets/images/banner_placeholder.png)

---

## ✨ Features

- 🔐 Firebase Authentication (Sign Up / Login)
- 🎞️ Movie Carousel with dynamic content
- 📅 Date & Time Picker with scrollable slots
- 🎟️ Booking Confirmation Screen
- 🛡️ Stripe-ready (for secure payment integration)
- 📱 Responsive UI

---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK (≥3.10)
- Dart SDK
- Android Studio or VS Code
- Firebase account (for your own deployment)

---

### 🛠️ Installation & Running

```bash
# Clone the repo
git clone https://github.com/deltay-deltax/Movie_Ticket_Booking-App.git
cd Movie_Ticket_Booking-App

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 🔐 APIs & Tools Used

| Service           | Purpose                          |
|------------------|----------------------------------|
| Firebase Auth     | User Login / Signup              |
| Firebase Firestore| (Optional) For dynamic movie data|
| Firebase Core     | Core initialization              |
| Stripe (optional) | Payment integration (future)     |
| Carousel Slider   | For movie banners                |
| Google Fonts      | Custom typography                |

> ⚠️ **Note:** `google-services.json` and `constant.dart` are excluded for security. Create your own in these paths:
>
> - `android/app/google-services.json` → From Firebase Console
> - `lib/service/constant.dart` → For storing API keys, constants (avoid pushing secrets)

Example `constant.dart` (do not upload to GitHub):

```dart
const String stripePublishableKey = 'pk_test_...';
const String stripeSecretKey = 'sk_test_...';
```

---

## 📁 Folder Structure

```
lib/
│
├── main.dart                  # App entry point
├── pages/                     # UI Pages (home, login, booking, etc.)
│   ├── home.dart
│   ├── login.dart
│   ├── signup.dart
│   └── detail_page.dart
│
├── service/
│   ├── constant.dart          # App constants (gitignored)
│   └── database.dart          # Firebase / API calls
```

---

## 📸 Screenshots

![WhatsApp Image 2025-08-01 at 21 13 05_3d286e1c](https://github.com/user-attachments/assets/e96f073a-618e-4b41-88b3-cf8c49cda57b)


![WhatsApp Image 2025-08-01 at 21 13 05_e630a48f](https://github.com/user-attachments/assets/1a257436-a2a8-4261-8a0e-f835f50057bc)

![WhatsApp Image 2025-08-01 at 21 13 05_fb19d38f](https://github.com/user-attachments/assets/6cc22bd7-3978-437f-9630-4e4bbfb36a51)


## 🔮 Future Enhancements

- ✅ Payment gateway (Stripe or Razorpay)
- ✅ Seat layout and availability
- ✅ Movie ratings and reviews
- ✅ Ticket history & cancellation
- ✅ Language filter, genre filter

---

## 🤝 Contributing

Pull requests are welcome! For major changes, please open an issue first.

---

## 📄 License

[MIT](LICENSE)

---

> Designed & Developed by Aaditya Gupta 💻
