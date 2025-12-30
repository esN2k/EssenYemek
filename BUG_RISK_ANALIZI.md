# Bug/Risk Analizi

- `company_information` create rule'u default doc icin acik; tek seferlik olsa da public yazma riski var.
- Default terms URL sabit; gercek ortama uygun domain ile guncellenmezse yanlis link gorunebilir.
- Seed istenmeden cok erken calisirsa offline/izin hatasi sessiz kalabilir (log only).
- Onboarding fallback listeleri backend ile senkron degilse tercih tutarliligi farkli olabilir.
- Integration testler web/desktop icin desteklenmiyor; CI icin Android/iOS runner gerektirir.
