import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['tr', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? trText = '',
    String? enText = '',
  }) =>
      [trText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

/// Used if the locale is not supported by GlobalMaterialLocalizations.
class FallbackMaterialLocalizationDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const FallbackMaterialLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      SynchronousFuture<MaterialLocalizations>(
        const DefaultMaterialLocalizations(),
      );

  @override
  bool shouldReload(FallbackMaterialLocalizationDelegate old) => false;
}

/// Used if the locale is not supported by GlobalCupertinoLocalizations.
class FallbackCupertinoLocalizationDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<CupertinoLocalizations>(
        const DefaultCupertinoLocalizations(),
      );

  @override
  bool shouldReload(FallbackCupertinoLocalizationDelegate old) => false;
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => _isSupportedLocale(locale);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

bool _isSupportedLocale(Locale locale) {
  final language = locale.toString();
  return FFLocalizations.languages().contains(
    language.endsWith('_')
        ? language.substring(0, language.length - 1)
        : language,
  );
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Splash
  {
    'ftlk10x5': {
      'tr': 'Essen',
      'en': 'Essen',
    },
    'xhhiwnms': {
      'tr': 'Yemek',
      'en': 'Food',
    },
    '31v5xhd9': {
      'tr': 'Başlayalım!',
      'en': 'Let\'s get started!',
    },
    '4wjpihri': {
      'tr': 'Zaten üye misiniz?  ',
      'en': 'Already a member?',
    },
    '8lsxlbi9': {
      'tr': 'Oturum Aç',
      'en': 'Log In',
    },
    '98afmct9': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // Giris
  {
    's2vy008c': {
      'tr': 'Oturum Aç',
      'en': 'Log In',
    },
    'j3xrk9jj': {
      'tr': 'E-posta',
      'en': 'Email',
    },
    'enkcecei': {
      'tr': 'dodikbalaman@gmail.com',
      'en': 'dodikbalaman@gmail.com',
    },
    '55ye3cf8': {
      'tr': 'Şifre',
      'en': 'Password',
    },
    'lhxezft7': {
      'tr': '123456',
      'en': '123456',
    },
    '2xnd42jl': {
      'tr': 'Email is required.',
      'en': 'Email is required.',
    },
    'dj1rve5w': {
      'tr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    '9tyhbmdw': {
      'tr': 'Passsword is required.',
      'en': 'Password is required.',
    },
    '6fhsm0au': {
      'tr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    '3lhh97lc': {
      'tr': 'Giriş Yap',
      'en': 'Login',
    },
    'ikxbufr4': {
      'tr': 'Şifremi hatırlamıyorum',
      'en': 'I don\'t remember my password',
    },
    '56rqthk3': {
      'tr': 'Henüz hesabın yok mu?',
      'en': 'Don\'t have an account yet?',
    },
    'm18p91z9': {
      'tr': 'Hesap Oluştur!',
      'en': 'Create Account!',
    },
    'nnh5sv0f': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // Onboarding_Slayt
  {
    'qaffj8g9': {
      'tr': 'Yerel, Özelleştirilmiş\nYemek Planlama',
      'en': 'Local, Customized\nMeal Planning',
    },
    'dvq8k6lg': {
      'tr':
          'Sağlıklı yemek seçeneklerimiz arasından kendi özelleştirilmiş yemek planınızı oluşturun.',
      'en':
          'Create your own customized meal plan from our selection of healthy meals.',
    },
    'lt12kdpa': {
      'tr': 'Lezzetli ve Besleyici Taze Yemekler',
      'en': 'Delicious and Nutritious Fresh Meals',
    },
    'afqq2gek': {
      'tr':
          'Taze, yüksek kaliteli malzemelerle hazırlanan, kapınıza kadar teslim edilen sağlıklı ve lezzetli yemeklerin tadını çıkarın.',
      'en':
          'Enjoy healthy and delicious meals made with fresh, high-quality ingredients, delivered right to your door.',
    },
    'tmze9jvy': {
      'tr': 'Gurme Kalitesi,\nZahmetsiz',
      'en': 'Gourmet Quality, Effortless',
    },
    '9yy6vzec': {
      'tr':
          'Gurme yemek dağıtım hizmetimizle, yemek pişirme veya temizlik zahmetine girmeden şeften ilham alan yemeklerin tadını çıkarın.',
      'en':
          'Enjoy chef-inspired meals without the hassle of cooking or cleanup with our gourmet meal delivery service.',
    },
    'ad9tk3z8': {
      'tr': 'Devam et',
      'en': 'Continue',
    },
    '6drb072m': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // Onboarding_HesapOlustur
  {
    'd9kxnl4m': {
      'tr': 'Hesap oluştur',
      'en': 'Create an account',
    },
    'dbt4iqx9': {
      'tr': 'Ad Soyad',
      'en': 'Name Surname',
    },
    '23mqq1h9': {
      'tr': 'E-posta',
      'en': 'Email',
    },
    '4hfqujz1': {
      'tr': 'Şifre',
      'en': 'Password',
    },
    'm4lppm7g': {
      'tr': 'Full name is required.',
      'en': 'Full name is required.',
    },
    'lk9f96e1': {
      'tr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    'iyd781wa': {
      'tr': 'Email is required.',
      'en': 'Email is required.',
    },
    '3b93m7va': {
      'tr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    'dtyrqbhc': {
      'tr': 'Password is required.',
      'en': 'Password is required.',
    },
    '1woik12o': {
      'tr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    'dq9psavc': {
      'tr': 'Hesap Oluştur',
      'en': 'Create Account',
    },
    '6ongsqy2': {
      'tr': '“Hesap Oluştur” seçeneğine tıklayarak EssenYemek\'in ',
      'en':
          'By clicking on the “Create Account” option, you can register with EssenYemek',
    },
    '2pblnw75': {
      'tr': 'Kullanım Koşullarını',
      'en': 'Terms of Use',
    },
    'bhixtav8': {
      'tr': ' kabul etmiş olursunuz.',
      'en': 'You accept.',
    },
    'v86fzc5i': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // Panel
  {
    'c4t4o3xf': {
      'tr': 'Bu haftanın yemekleri',
      'en': 'This week\'s dishes',
    },
    'ypkv73np': {
      'tr': 'Her hafta taze malzemelerle sipariş üzerine yapılır.',
      'en': 'Made to order with fresh ingredients every week.',
    },
    '8hmmat3d': {
      'tr': 'Yemekler',
      'en': 'Foods',
    },
  },
  // YemekDetaylar
  {
    'p7j8y38u': {
      'tr': 'Malzemeler',
      'en': 'Materials',
    },
    'pobcme6j': {
      'tr': 'Alerjenler',
      'en': 'Allergens',
    },
    'mjqhhvq9': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // Profil
  {
    'c3kv9o0d': {
      'tr': 'Bizi desteklediğiniz için teşekkür ederiz!',
      'en': 'Thank you for supporting us!',
    },
    'kgh51cuf': {
      'tr':
          'Yerel bir işletme olarak bizi desteklediğiniz için teşekkür eder, iyi eğlenceler dileriz.',
      'en':
          'Thank you for supporting us as a local business and we hope you have fun.',
    },
    'ircptpp9': {
      'tr': 'Profil Düzenle',
      'en': 'Edit Profile',
    },
    '57x88ouh': {
      'tr': 'Yemek Tercihleri',
      'en': 'Food Preferences',
    },
    '0ncruabu': {
      'tr': 'Hakkımızda',
      'en': 'About Us',
    },
    'lij60voe': {
      'tr': 'Destek Merkezi',
      'en': 'Support Center',
    },
    '46uk37z7': {
      'tr': 'Bize Ulaşın',
      'en': 'Contact us',
    },
    'bwl07a9y': {
      'tr': 'EssenYemek Uygulamasını Paylaş',
      'en': 'Share EssenYemek App',
    },
    'tciosm8t': {
      'tr': 'App Store\'da İncele',
      'en': 'Check it out on the App Store',
    },
    'gv8a91o1': {
      'tr': 'Oturumu kapat',
      'en': 'Log out',
    },
    'upjxgphb': {
      'tr': 'Profil',
      'en': 'Profile',
    },
  },
  // ProfiliDuzenle
  {
    'h5o4ato9': {
      'tr': 'Profili Düzenle',
      'en': 'Edit Profile',
    },
    '3o2812gv': {
      'tr': 'Ad Soyad',
      'en': 'Name Surname',
    },
    'd3n4xbcd': {
      'tr': '',
      'en': '',
    },
    'ect2f8wa': {
      'tr': '',
      'en': '',
    },
    'hr2y9oa3': {
      'tr': 'Şifre Sıfırlama',
      'en': 'Password Reset',
    },
    'q3h3nqv8': {
      'tr': 'Hesabı Sil',
      'en': 'Delete Account',
    },
    'w5k5wmw2': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // Hakkimizda
  {
    'bnkxu3y2': {
      'tr': 'Hakkımızda',
      'en': 'About Us',
    },
    'ldsk4k8r': {
      'tr': 'Aşçılarınız',
      'en': 'Your cooks',
    },
    '05h4mca9': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // YemeTercihleri
  {
    '8qqy010q': {
      'tr': 'Yemek Tercihleri',
      'en': 'Food Preferences',
    },
    'ff5kww42': {
      'tr': 'Diyet',
      'en': 'Diet',
    },
    'rr9egqgr': {
      'tr': 'Alerjenler',
      'en': 'Allergens',
    },
    'eqsljcfa': {
      'tr': 'Sevilmeyen Malzemeler',
      'en': 'Disliked Ingredients',
    },
    'rlvb21id': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // DestekMerkezi
  {
    'j0taqs22': {
      'tr': 'Destek Merkezi',
      'en': 'Support Center',
    },
    'l2n580ow': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // SifreUnuttum
  {
    'cm13q2us': {
      'tr': 'Şifremi unuttum',
      'en': 'I forgot my password',
    },
    'dg7yzmtl': {
      'tr': 'Şifrenizi sıfırlamanız için size bir e-posta göndereceğiz.',
      'en': 'We will send you an email to reset your password.',
    },
    '4clpr9je': {
      'tr': 'E-posta',
      'en': 'Email',
    },
    'avd910a8': {
      'tr': '',
      'en': '',
    },
    'ngnxh2hm': {
      'tr': '',
      'en': '',
    },
    '6pzz9d4w': {
      'tr': 'Email is required.',
      'en': 'Email is required.',
    },
    'sctqhtpn': {
      'tr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    '41xxuolz': {
      'tr': 'Şifre Sıfırlama',
      'en': 'Password Reset',
    },
    'qoxde1fc': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // TercihleriDuzenle
  {
    'lu3dj396': {
      'tr': 'Diyeti güncelleyin',
      'en': 'Update the diet',
    },
    '3czgpbc4': {
      'tr': 'Update allergies',
      'en': 'Update on allergies',
    },
    '1d7qfql6': {
      'tr': 'Update dislikes',
      'en': 'Update dislikes',
    },
    'b1h6hi6e': {
      'tr': 'Update',
      'en': 'Update',
    },
    'q6s7j463': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // Onboarding
  {
    'pb7vd1dr': {
      'tr': 'Diyetinizi seçin',
      'en': 'Choose your diet',
    },
    'amodiz20': {
      'tr': 'Any allergies?',
      'en': 'Any allergies?',
    },
    'm7inv3vo': {
      'tr': 'How about dislikes?',
      'en': 'What about dislikes?',
    },
    'py1kjc9m': {
      'tr': 'Devam et',
      'en': 'Continue',
    },
    'qks3s4xq': {
      'tr': 'Home',
      'en': 'Home',
    },
  },
  // mealBottomSheet
  {
    'f07s7tjv': {
      'tr': 'Share meal details',
      'en': 'Share meal details',
    },
    '90ogrt1b': {
      'tr': 'Send feedback',
      'en': 'Send feedback',
    },
  },
  // feedbackBottomSheet
  {
    '1yod7mp2': {
      'tr': 'Anonim Geri Bildirim Gönderin',
      'en': 'Submit Anonymous Feedback',
    },
    '224uodu6': {
      'tr': 'Bir şeyler yaz.',
      'en': 'Write something.',
    },
    'vdzn0jtn': {
      'tr': 'Feedback is required.',
      'en': 'Feedback is required.',
    },
    'zz097kd4': {
      'tr': 'Please choose an option from the dropdown',
      'en': 'Please choose an option from the dropdown',
    },
    'd2v8g821': {
      'tr': 'Geri Bildirim Gönder',
      'en': 'Send Feedback',
    },
  },
  // Miscellaneous
  {
    'r1nvfjgp': {
      'tr':
          'EssenYemek\'in size yemek güncellemeleri ve diğer önemli mesajlar hakkında bildirimler göndermesi gerekir.',
      'en':
          'EssenYemek needs to send you notifications about food updates and other important messages.',
    },
    'sgqqgscx': {
      'tr': 'Hata: ',
      'en': 'Error: ',
    },
    'n92be62l': {
      'tr': 'Şifre sıfırlama e-postası gönderildi!',
      'en': 'Password reset email has been sent!',
    },
    '1ecm4fwf': {
      'tr': 'E-posta gerekli!',
      'en': 'Email required!',
    },
    'qsk3eku9': {
      'tr': 'Telefon numarası gereklidir ve + ile başlamalıdır.',
      'en': 'The phone number is required and must begin with +.',
    },
    'q8rm2xva': {
      'tr': 'Parolalar eşleşmiyor',
      'en': 'Passwords do not match',
    },
    'uzlgqtgw': {
      'tr': 'SMS doğrulama kodunu girin',
      'en': 'Enter SMS verification code',
    },
    's9jc94lf': {
      'tr':
          'En son oturum açmanızın üzerinden çok uzun zaman geçti. Hesabınızı silmeden önce tekrar giriş yapın.',
      'en':
          'It\'s been too long since you last logged in. Log in again before deleting your account.',
    },
    'ch4pfpm9': {
      'tr':
          'En son oturum açmanızın üzerinden çok uzun zaman geçti. E-postanızı güncellemeden önce tekrar oturum açın.',
      'en':
          'It\'s been too long since you last signed in. Sign in again before updating your email.',
    },
    'avz1nxja': {
      'tr': 'E-posta değişikliği onay e-postası gönderildi!',
      'en': 'Email change confirmation email has been sent!',
    },
    'ix63qsna': {
      'tr':
          'Sağlanan kimlik doğrulama bilgisi yanlış, hatalı biçimlendirilmiş veya süresi dolmuş',
      'en':
          'The provided authentication information is incorrect, malformed, or expired',
    },
    'zikarxs8': {
      'tr':
          'Sağlanan kimlik doğrulama bilgisi yanlış, hatalı biçimlendirilmiş veya süresi dolmuş',
      'en':
          'The provided authentication information is incorrect, malformed, or expired',
    },
    'ehkwxexf': {
      'tr': '',
      'en': '',
    },
    'qhs01vlu': {
      'tr': '',
      'en': '',
    },
    'alnuvjrk': {
      'tr': '',
      'en': '',
    },
    'g9d4iu6q': {
      'tr': '',
      'en': '',
    },
    'kr9uvcb1': {
      'tr': '',
      'en': '',
    },
    '0waui4s1': {
      'tr': '',
      'en': '',
    },
    'tkveptrz': {
      'tr': '',
      'en': '',
    },
    '598ndygu': {
      'tr': '',
      'en': '',
    },
    'c5ztd9b8': {
      'tr': '',
      'en': '',
    },
    'zkrbpdro': {
      'tr': '',
      'en': '',
    },
    'jd2pv8zc': {
      'tr': '',
      'en': '',
    },
    'oy9r5abg': {
      'tr': '',
      'en': '',
    },
    'hmzlukad': {
      'tr': '',
      'en': '',
    },
    'ymqqblgd': {
      'tr': '',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
