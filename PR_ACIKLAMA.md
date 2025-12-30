# PR Aciklama

## Ne yapildi
- Onboarding icin fallback veri ve terms metni bos durumda da gorunecek sekilde duzenlendi.
- `company_information` icin default doc seed eklendi; Firestore rules buna uygun guncellendi.
- Generated dosyalar repodan cikarildi ve `.gitignore` ile kalici olarak dislandi.
- Testler eklendi: company info service, onboarding component widget testleri, plan/order akisi entegrasyon testi.

## Nasil test edilir
1. `flutter analyze`
2. `flutter test`
3. `flutter test integration_test -d <android|ios>`
   - Web icin integration test desteklenmiyor.
