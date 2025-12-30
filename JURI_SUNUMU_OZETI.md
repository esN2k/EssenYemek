# Proje Sunumu: Akıllı Yemek Kutusu Platformu

## 🏆 Amaç
Modern yemek kutusu hizmetini (HelloFresh/Freshly benzeri) en güncel teknolojilerle, gerçek kullanıcı verisi ve güçlü bir arayüz ile hayata geçirmek. Kullanıcıların haftalık plan yapabildiği, esnek sipariş oluşturup takip edebildiği bir deneyim sunmak.

## 🧰 Kullanılan Teknolojiler
- **Flutter** (UI, multiplatform desteği)
- **Firebase Auth & Firestore** (anlık veri, cloud authentication ve güvenlik kuralları)
- **FlutterFlow** ekosistemi
- **Google Fonts**

## 🔑 Temel Özellikler & Yenilikler
- Plan oluşturma/güncelleme, haftalık yemek seçimi
- Sipariş oluşturma ve geçmiş/aktif sipariş yönetimi
- Firestore ile kalıcı, güvenli veri akışı ve kurallı erişim
- State ve servis tabanlı mimari; logout ve senkronizasyon
- Modern, mobil uyumlu, kullanıcı odaklı UI

## 🗂 Ana Modül ve Akışlar
1. **Plan Yönetimi** – Plan tipi belirleme, yemek seçimi, kaydetme
2. **Sipariş Akışı** – Planı siparişe dönüştürme; aktif/geçmiş siparişler
3. **Profil ve Tercihler** – Kullanıcı yönetimi, onboarding
4. **Servis Katmanı** – State ile Firestore arasında tam senkronizasyon
5. **Test & Demo** – flutter test & cihazlı integration test desteği

## 👁️‍🗨️ Demo/Test Keyfi
- `flutter test`, `flutter analyze` ile tam coverage
- Android cihaz/emulatorde: `flutter test integration_test/flow_test.dart -d emulator-5554`
- Demo veri: PlanService.seedSamplePlan ve OrderService.seedSampleOrders

## 🏛️ Mimari Vurgu
- Firestore tabanlı servis yapısı
- Bileşen tabanlı modern Flutter UI
- Detaylı güvenlik (firestore.rules ile user_ref kontrolü)
- Kodda net modülerlik: backend (servis), sayfalar (UI), bileşenler (widget)

## ⚠️ Sınırlama & Öğrendiklerimiz
- Gerçek cihaz/emulator bağımlılığı nedeniyle entegrasyon testlerinde stabiliteye dikkat edilmeli (adb Tool güncellemesi/kapat-aç önerilir)
- Gelecek geliştirme önerileri: iptal/iade, teslimat takibi, ödeme simülasyonu, offline cache ve CI ile sürekli test