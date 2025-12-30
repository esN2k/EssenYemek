# Proje Dökümantasyonu

## Proje Özeti
Kullanıcılar haftalık yemek planı oluşturur, seçimlerini planlar ve siparişlerini oluşturur – tüm veriler Firestore’da kalıcı tutulur. Modern Flutter tabanlı tasarım ve güvenli bulut mimarisi ile scalable bir yemek kutusu çözümü.

## Kurulum Adımları
1. **Flutter SDK** yüklü olmalı.
2. Depoyu klonla:  
   ```
   git clone <repo-url>
   cd <proje>
   ```
3. Gerekli paketleri kur:
   ```
   flutter pub get
   ```
4. **Firebase yapılandırması:**
   - `google-services.json`’u (Android) ve `GoogleService-Info.plist`’i (iOS) ilgili dizinlere ekle.
   - Web için `firebase_config.dart`’ı ayarla.

## Bağımlılıklar
- `cloud_firestore`, `firebase_auth`, `firebase_core`
- `integration_test`, `fake_cloud_firestore`
- Android için: build.gradle, AGP, NDK, JDK 21 uyumu gereklidir.

## Konfigürasyon
- Android: build.gradle, settings.gradle, gradle-wrapper.properties güncel olmalı.
- Firebase erişim kuralları ve indeks dosyaları:  
  `firestore.rules`, `firestore.indexes.json`
- Gerekli .env/secret dosyalarını ve servis hesaplarını ekleyin.

## Test ve Çalıştırma Talimatları
- Kod analiz:
  ```
  flutter analyze
  ```
- Unit/Widget Testleri:
  ```
  flutter test
  ```
- Integration Test (Android cihaz/emulator):
  ```
  flutter test integration_test/flow_test.dart -d <android_device_id>
  ```
  *Not: adb hatasında emulator/kontrol server yeniden başlatılmalı.*

## Kod Organizasyonu
- **Backend (lib/backend/):** Firestore servisleri ve yardımcı fonksiyonlar
- **UI/Sayfalar (lib/sayfalar/):** Plan, sipariş, onboarding, profil ve ana ekranlar
- **Bileşenler (lib/bilesenlercomp/):** Yeniden kullanılabilir widget’lar
- **Model ve State (lib/app_state.dart vb.):** Global uygulama durumu ve domain modelleri

## Geliştirici Rehberi
- Yeni plan tipi ekle: PlanService’da default’larını güncelle.
- Sipariş oluştur: `OrderService.createOrderFromPlan`
- Demo veri oluştur: `PlanService.seedSamplePlan`/`OrderService.seedSampleOrders`
- Firestore kurallarını deploy etmek için:
  ```
  firebase deploy --only firestore
  ```
- Android build zinciri JDK, AGP ve NDK’ya tam uyumlu olmalı.

## Bilinen Sınırlamalar
- Emulator/device stabilitesi entegrasyon testlerini etkileyebilir.
- Plan/sipariş state senkronunda edge case’ler için ek guard önerilir.
- Repo’da LICENSE yoksa ekleyip CONTRIBUTING.md standardını uygula.

## Yol Haritası
- Emulator/ADB için cold-boot ve platform-tools güncellemesini sürdür.
- Order iptal/iade, teslimat ve ödeme akışı eklenebilir.
- Firestore offline desteği ve hatalı ağ koşullarında davranış test edilmeli.
- CI entegrasyonu ile otomatik test/kalite devam ettirilmeli.