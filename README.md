# 🚀 Junior Case Boilerplate

**NodeLabs Junior Developer Case Study için hazırlanmış profesyonel Flutter boilerplate projesi**

Bu proje, junior geliştiricilerin Flutter ile modern, ölçeklenebilir ve sürdürülebilir mobil uygulamalar geliştirmek için ihtiyaç duyacakları temel yapı taşlarını içeren kapsamlı bir başlangıç şablonudur.

## 📋 İçindekiler

- [Özellikler](#-özellikler)
- [Proje Yapısı](#-proje-yapısı)
- [Kurulum](#-kurulum)
- [Kullanım](#-kullanım)
- [Mimari](#-mimari)
- [Geliştirme Rehberi](#-geliştirme-rehberi)
- [Katkıda Bulunma](#-katkıda-bulunma)

## ✨ Özellikler

### 🎯 Temel Özellikler
- **Temiz Mimari**: Feature-first yaklaşımı ile modüler yapı
- **Responsive Tasarım**: Tüm cihaz boyutlarına uyumlu
- **Tema Sistemi**: Dark/Light mode desteği
- **Routing**: Gelişmiş navigasyon sistemi
- **State Management**: Hazır state management yapısı
- **Form Validation**: Kapsamlı form doğrulama sistemi

### 📱 Uygulama Modülleri
- **Authentication**: Giriş/Kayıt ve sosyal medya entegrasyonu
- **Home**: Ana sayfa ve içerik gösterimi
- **Profile**: Kullanıcı profil yönetimi
- **Navigation**: Alt navigasyon menüsü
- **Upload Photo**: Fotoğraf yükleme ve düzenleme
- **Splash**: Uygulama başlangıç ekranı

## 🏗 Proje Yapısı

```
lib/
├── core/                          # Çekirdek sistem bileşenleri
│   ├── constants/                 # Uygulama sabitleri
│   │   ├── app_colors.dart       # Renk paleti
│   │   ├── app_paddings.dart     # Padding değerleri
│   │   ├── app_radius.dart       # Border radius değerleri
│   │   ├── app_strings.dart      # Metin sabitleri
│   │   └── app_text_styles.dart  # Tipografi stilleri
│   ├── enums/                     # Enum tanımlamaları
│   │   ├── app/
│   │   │   └── app_local_storage_keys.dart
│   │   └── assets/
│   │       ├── app_fonts.dart
│   │       ├── app_icons.dart
│   │       └── app_images.dart
│   ├── extensions/                # Dart extensions
│   │   ├── app/
│   │   │   ├── app_padding_ext.dart
│   │   │   ├── app_radius_ext.dart
│   │   │   └── bottom_sheet_ext.dart
│   │   └── assets/
│   │       ├── app_icons_ext.dart
│   │       └── app_images_ext.dart
│   ├── helpers/                   # Yardımcı sınıflar
│   │   └── bottom_sheet/
│   ├── mixins/                    # Dart mixins
│   │   └── validators_mixin.dart
│   ├── models/                    # Veri modelleri
│   │   └── offer_package_model.dart
│   ├── routes/                    # Routing sistemi
│   │   ├── app_router.dart
│   │   └── app_routes.dart
│   └── widgets/                   # Ortak widget'lar
│       ├── app_bar/
│       ├── bottom_sheet/
│       ├── buttons/
│       ├── cached_network_image/
│       ├── nav_bar/
│       └── text_form_field/
├── features/                      # Özellik modülleri
│   ├── auth/                     # Kimlik doğrulama
│   │   ├── enums/
│   │   ├── extensions/
│   │   ├── models/
│   │   ├── views/
│   │   └── widgets/
│   ├── home/                     # Ana sayfa
│   ├── nav_bar/                  # Navigasyon
│   ├── profile/                  # Profil
│   ├── splash/                   # Başlangıç
│   └── upload_photo/             # Fotoğraf yükleme
└── main.dart                     # Uygulama giriş noktası
```

## 🛠 Kurulum

### Ön Gereksinimler
- Flutter SDK (3.8.1+)
- Dart SDK
- Android Studio / VS Code
- iOS geliştirme için Xcode (macOS)

### Adım 1: Projeyi Klonlayın
```bash
git clone [repository-url]
cd jr_case_boilerplate
```

### Adım 2: Bağımlılıkları Yükleyin
```bash
flutter pub get
```

### Adım 3: Platformları Yapılandırın

#### Android
```bash
flutter build apk --debug
```

#### iOS
```bash
flutter build ios --debug
```

### Adım 4: Uygulamayı Çalıştırın
```bash
flutter run
```

## 🎯 Kullanım

### Yeni Feature Ekleme

1. `lib/features/` klasörü altında yeni bir klasör oluşturun
2. Feature yapısını takip edin:
```
feature_name/
├── enums/
├── extensions/
├── models/
├── views/
└── widgets/
```

### Widget Oluşturma

1. Ortak widget'lar için `lib/core/widgets/` kullanın
2. Feature-specific widget'lar için ilgili feature'ın `widgets/` klasörünü kullanın

### Tema Özelleştirme

1. `lib/core/constants/` klasöründeki dosyaları düzenleyin:
   - `app_colors.dart` - Renk paleti
   - `app_text_styles.dart` - Tipografi
   - `app_paddings.dart` - Boşluk değerleri

## 🏛 Mimari

Bu proje **Feature-First Architecture** yaklaşımını benimser:

### Katmanlar
1. **Presentation Layer**: Views ve Widgets
2. **Business Logic Layer**: State management ve business logic
3. **Data Layer**: Models ve data sources

### Prensipler
- **Separation of Concerns**: Her modül kendi sorumluluğuna odaklanır
- **Dependency Injection**: Gevşek bağlılık
- **Testability**: Kolay test edilebilir yapı
- **Scalability**: Büyüyen projelere uygun

## 📚 Geliştirme Rehberi

### Code Style
- Dart resmi style guide'ını takip edin
- `flutter_lints` kurallarına uyun
- Meaningful naming conventions kullanın

### Best Practices
1. **Widget Composition**: Küçük, yeniden kullanılabilir widget'lar oluşturun
2. **State Management**: Uygun state management çözümü seçin
3. **Performance**: Build method'larını optimize edin
4. **Accessibility**: Erişilebilirlik standartlarına uyun

### Testing
```bash
# Unit testler
flutter test

# Widget testler
flutter test test/widget_test.dart

# Integration testler
flutter drive --target=test_driver/app.dart
```

## 🤝 Katkıda Bulunma

1. Fork yapın
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Commit yapın (`git commit -m 'Add some amazing feature'`)
4. Branch'i push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📞 Destek

Bu boilerplate hakkında sorularınız için:
- GitHub Issues kullanın
- Dokümantasyonu inceleyin
- Flutter topluluğuna başvurun

## 📄 Lisans

Bu proje MIT lisansı altında lisanslanmıştır. Detaylar için `LICENSE` dosyasına bakın.

---

**NodeLabs tarafından junior geliştiriciler için özel olarak hazırlanmıştır** 🚀

### 🎓 Öğrenme Kaynakları

- [Flutter Dokümantasyonu](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://docs.flutter.dev/development/ui/widgets)
- [Material Design Guidelines](https://material.io/design)
