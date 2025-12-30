# Refactor Onerisi

## Hedef
Terms metni uretimini tek bir helper fonksiyona tasiyip okunabilirligi artirmak.

## Ornek
```dart
Widget buildTermsNotice(BuildContext context, String termsUrl) {
  final hasTermsUrl = termsUrl.trim().isNotEmpty;
  final baseStyle = FlutterFlowTheme.of(context).bodySmall;
  final text = RichText(
    textScaler: MediaQuery.of(context).textScaler,
    text: TextSpan(
      children: [
        TextSpan(text: FFLocalizations.of(context).getText('6ongsqy2')),
        TextSpan(
          text: FFLocalizations.of(context).getText('2pblnw75'),
          style: baseStyle.override(
            fontFamily: 'Sora',
            decoration: hasTermsUrl ? TextDecoration.underline : TextDecoration.none,
          ),
        ),
        TextSpan(text: FFLocalizations.of(context).getText('bhixtav8')),
      ],
      style: baseStyle.override(fontFamily: 'Sora'),
    ),
    textAlign: TextAlign.center,
  );

  if (!hasTermsUrl) return text;
  return InkWell(onTap: () => launchURL(termsUrl), child: text);
}
```
