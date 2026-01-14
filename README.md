# ✨ Relaksasi-Audio-App

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![Web](https://img.shields.io/badge/Web-4285F4?style=for-the-badge&logo=google-chrome&logoColor=white)
![Windows](https://img.shields.io/badge/Windows-0078D6?style=for-the-badge&logo=windows&logoColor=white)
![Code Quality](https://img.shields.io/badge/Code%20Quality-High-brightgreen?style=for-the-badge)

> Aplikasi seluler lintas platform yang dibangun dengan Flutter, dirancang sebagai aplikasi meditasi/kesejahteraan. Proyek ini menampilkan pengalaman onboarding yang menarik, antarmuka beranda yang dipersonalisasi dengan rekomendasi, dan pemutar audio untuk sesi meditasi, didukung oleh aset multimedia yang kaya dan arsitektur berbasis fitur yang bersih.

## ✨ Fitur Utama

Berikut adalah beberapa fitur utama yang ditawarkan oleh aplikasi ini:

*   **Pengalaman Onboarding Interaktif:** Pengguna baru disambut dengan alur onboarding yang menarik secara visual (`screenshots/flutter_01.png`), dirancang untuk memperkenalkan fungsionalitas inti aplikasi dengan lancar.
*   **Beranda yang Dipersonalisasi:** Layar beranda (`screenshots/flutter_02.png`) menampilkan rekomendasi meditasi yang dikurasi, diatur berdasarkan suasana hati dan kategori, memanfaatkan data dari `mood_data.dart` dan `recommendations.dart`.
*   **Pemutar Audio Meditasi Imersif:** Aplikasi ini menyediakan pemutar audio khusus (`screenshots/flutter_03.png`, `screenshots/flutter_04.png`) untuk memutar trek meditasi yang menenangkan, dengan dukungan untuk mode terang dan gelap, dan aset audio yang kaya (`assets/audio`).
*   **Desain UI/UX yang Kaya:** Memanfaatkan ikon khusus (`assets/icons`), gambar (`assets/images`), dan animasi Lottie (`assets/lottie/yoga.json`, `yoga2.json`) untuk menciptakan pengalaman pengguna yang menarik dan responsif.
*   **Dukungan Multi-platform:** Dibangun dengan Flutter, aplikasi ini dirancang untuk beroperasi secara mulus di berbagai platform termasuk Android, iOS, Web, dan Windows, memastikan jangkauan audiens yang luas.
*   **Arsitektur Berbasis Fitur Bersih:** Proyek ini mengikuti prinsip-prinsip arsitektur bersih, dengan kode yang diatur secara logis ke dalam fitur-fitur yang berbeda (misalnya, `home`, `onboarding`, `player`). Setiap fitur memisahkan lapisan data, model, dan UI (layar/widget) untuk pemeliharaan dan skalabilitas yang lebih baik.

## 🛠️ Tumpukan Teknologi

Proyek ini dibangun menggunakan teknologi berikut:

| Kategori              | Teknologi         | Catatan                                                              |
| :-------------------- | :----------------- | :------------------------------------------------------------------- |
| **Kerangka Kerja UI** | Flutter            | Kerangka kerja UI terkemuka untuk membangun aplikasi multi-platform secara natif dari satu basis kode. |
| **Bahasa Pemrograman**| Dart               | Bahasa yang dioptimalkan untuk UI yang digunakan oleh Flutter.       |
| **Manajemen Paket**   | Pub (Dart)         | Manajer paket resmi untuk Dart dan Flutter.                         |
| **Pengembangan Android**| Gradle, Kotlin     | Sistem build dan bahasa untuk bagian asli Android.                   |
| **Pengembangan iOS**  | Xcode, CocoaPods, Swift | Lingkungan pengembangan dan manajer dependensi untuk bagian asli iOS. |
| **Kualitas Kode**     | Dart Analyzer      | Alat analisis statis untuk menegakkan praktik dan gaya pengodean yang konsisten melalui `analysis_options.yaml`. |
| **Aset UI/UX**        | Lottie, Gambar, Audio, Ikon | Untuk animasi vektor, visual statis, dan konten audio imersif. |

## 🏛️ Tinjauan Arsitektur

Proyek ini mengadopsi pendekatan **arsitektur bersih berbasis fitur**, di mana setiap bagian utama fungsionalitas (`features`) diisolasi dan diatur secara mandiri. Struktur ini mempromosikan modularitas, pemisahan perhatian, dan kemudahan pemeliharaan.

Struktur arsitektur utama meliputi:

*   **Direktori `features`:** Semua fungsionalitas inti aplikasi dienkapsulasi dalam folder ini.
*   **Folder `data`:** Mengandung logika untuk pengambilan dan pengelolaan data, seperti rekomendasi atau informasi suasana hati.
*   **Folder `model`:** Berisi definisi kelas model untuk merepresentasikan struktur data aplikasi (misalnya, `MoodModel`, `RecommendationModel`).
*   **Folder `screens`:** Bertanggung jawab untuk menyajikan antarmuka pengguna, menampung semua komponen UI tingkat tinggi.
*   **Folder `widgets`:** Berisi komponen UI yang dapat digunakan kembali yang lebih kecil, yang digunakan di berbagai layar.

## 🚀 Memulai

Untuk mengatur dan menjalankan proyek ini di lingkungan lokal Anda, ikuti langkah-langkah berikut:

### Prasyarat

Pastikan Anda telah menginstal Flutter SDK di mesin Anda. Jika belum, ikuti panduan instalasi di [dokumentasi Flutter resmi](https://docs.flutter.dev/get-started/install).

### Instalasi

1.  **Kloning repositori:**
    ```bash
    git clone https://github.com/maizatullisa/Flutter_PemrogramanBergerak.git
    cd Flutter_PemrogramanBergerak
    ```

2.  **Instal dependensi Flutter:**
    ```bash
    flutter pub get
    ```

3.  **Jalankan aplikasi:**
    ```bash
    flutter run
    ```
    Pilih perangkat target (emulator, perangkat fisik, atau browser web) saat diminta.

## 📂 Struktur File

Berikut adalah ikhtisar struktur direktori utama proyek:

```
/
├── .gitignore
├── .metadata
├── README.md
├── analysis_options.yaml
├── android
│   ├── .gitignore
│   ├── app
│   └── build.gradle
├── assets
│   ├── audio
│   ├── icons
│   ├── images
│   └── lottie
├── ios
│   ├── .gitignore
│   ├── Flutter
│   ├── Podfile
│   ├── Podfile.lock
│   ├── Runner.xcodeproj
│   ├── Runner.xcworkspace
│   ├── Runner
│   └── RunnerTests
├── lib
│   ├── features
│   │   ├── home
│   │   │   ├── data
│   │   │   ├── model
│   │   │   ├── screens
│   │   │   └── widgets
│   │   ├── onboarding
│   │   │   └── screens
│   │   └── player
│   │       └── screens
│   └── main.dart
├── pubspec.lock
├── pubspec.yaml
├── screenshots
│   ├── flutter_01.png
│   ├── flutter_02.png
│   ├── flutter_03.png
│   └── flutter_04.png
├── test
│   └── widget_test.dart
├── web
│   ├── favicon.png
│   ├── icons
│   ├── index.html
│   └── manifest.json
└── windows
    ├── .gitignore
    ├── CMakeLists.txt
    ├── flutter
    └── runner
```

*   **`android/`**: Berisi file proyek khusus Android.
*   **`assets/`**: Menyimpan semua aset aplikasi seperti file audio (`audio/`), ikon (`icons/`), gambar (`images/`), dan animasi Lottie (`lottie/`).
*   **`ios/`**: Berisi file proyek khusus iOS.
*   **`lib/`**: Direktori inti untuk kode Dart aplikasi Anda.
    *   **`features/`**: Mengorganisir semua fungsionalitas inti aplikasi ke dalam modul-modul yang terpisah (misalnya, `home`, `onboarding`, `player`), masing-masing dengan data, model, dan komponen UI-nya sendiri.
    *   **`main.dart`**: Titik masuk utama aplikasi Flutter.
*   **`screenshots/`**: Berisi gambar tangkapan layar yang menampilkan berbagai tampilan aplikasi.
*   **`web/`**: Berisi file proyek khusus web.
*   **`windows/`**: Berisi file proyek khusus Windows.
*   **`pubspec.yaml`**: File konfigurasi yang mendefinisikan dependensi proyek dan metadata.
*   **`analysis_options.yaml`**: Konfigurasi untuk penganalisis Dart, menegakkan aturan dan gaya kode.
  
# **Tampilan Mobile**
<img width="364" height="642" alt="image" src="https://github.com/user-attachments/assets/ca6cfbb8-4143-48d9-ba54-8382c6bd273d" />
<img width="364" height="642" alt="image" src="https://github.com/user-attachments/assets/7fd7cf5d-33c7-48b6-a10b-9f9cf3de2d58" />
<img width="364" height="642" alt="image" src="https://github.com/user-attachments/assets/bde427fe-cbad-475d-894f-0763dfa06bf1" />


# **Tampilan Mobile (Light Mode)**
![Player Light Mode](screenshots/flutter_03.png)
# **Tampilan Mobile (Dark Mode)**
![Player Dark Mode](screenshots/flutter_04.png)

# file structure
    1. In this project clean architecture is used.
    2. Everything is in features folder.
    3. `data` folder contains the data like recommendation.
    4. `screens` this folder has all the UI
    5. `models` this folder has the model classes e.g. MoodModel
