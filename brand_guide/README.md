# Multiterapia — Brand Kit

Identidade visual completa para o aplicativo Flutter **Multiterapia** —
gestão de terapias (fonoaudiologia · fisioterapia · psicologia) com perfis
de Terapeuta e Paciente.

## Estrutura

```
multiterapia/
├── svg/                   Vetores mestres (use no app via flutter_svg)
├── android/               Launcher icons + adaptive icons (Android 8+)
├── ios/                   AppIcon.appiconset pronto para Xcode
├── splash/                Splash screens (light & dark) em 3 densidades
└── brand/                 Masters 1024 px + Brand Guide PDF
```

## Como integrar no Flutter

### 1. Ícones do app

Copie o conteúdo de:

- `android/mipmap-*/` para `android/app/src/main/res/mipmap-*/`
- `android/adaptive/mipmap-*/` para `android/app/src/main/res/mipmap-*/`
  (sobrescreve apenas os foregrounds — não conflita com o ic_launcher.png)
- `android/adaptive/mipmap-anydpi-v26/` para `android/app/src/main/res/mipmap-anydpi-v26/`
- `android/adaptive/values/` para `android/app/src/main/res/values/`
- `ios/AppIcon.appiconset/` para `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
  (substitua a pasta inteira)

### 2. SVGs dentro do app

Adicione `flutter_svg` ao `pubspec.yaml`:

```yaml
dependencies:
  flutter_svg: ^2.0.10
flutter:
  assets:
    - assets/logo/
```

Copie os SVGs de `svg/` para `assets/logo/` e use:

```dart
SvgPicture.asset('assets/logo/multiterapia_icon_primary.svg', width: 64)
```

### 3. Splash screen

Use o pacote `flutter_native_splash`:

```yaml
dev_dependencies:
  flutter_native_splash: ^2.4.0

flutter_native_splash:
  color: "#F5F1EB"           # LIGHT (paleta da marca)
  image: assets/logo/multiterapia_mark_only.svg
  android_12:
    color: "#F5F1EB"
    image: assets/logo/multiterapia_mark_only.svg
  color_dark: "#1F2937"      # INK
  image_dark: assets/logo/multiterapia_mark_only_dark.svg
```

Ou simplesmente use os PNGs em `splash/` como background.

## Paleta de cores (use no tema)

```dart
class MultiterapiaColors {
  static const teal   = Color(0xFF0F766E);  // Primary
  static const coral  = Color(0xFFF97362);  // Accent
  static const light  = Color(0xFFF5F1EB);  // Surface
  static const border = Color(0xFFE5DFD3);
  static const ink    = Color(0xFF1F2937);  // Primary text
  static const muted  = Color(0xFF5C7B7A);  // Secondary text
}
```

## Tipografia

A fonte da marca é **Poppins** (Google Fonts). Adicione ao `pubspec.yaml`:

```yaml
dependencies:
  google_fonts: ^6.2.1
```

Uso recomendado:

```dart
TextTheme textTheme = GoogleFonts.poppinsTextTheme();
```

Pesos:
- **Light (300)** — captions, hints
- **Regular (400)** — body
- **Medium (500)** — headings, wordmark
- **Bold (700)** — destaques fortes

## Brand Guide

Veja `brand/multiterapia_brand_guide.pdf` para o guia visual completo.

---

Gerado em maio de 2026.
