import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Idiomas suportados pelo app.
enum AppLanguage {
  pt('pt', 'BR'),
  en('en', 'US'),
  es('es', 'ES');

  final String languageCode;
  final String countryCode;
  const AppLanguage(this.languageCode, this.countryCode);

  Locale get locale => Locale(languageCode, countryCode);

  static AppLanguage fromCode(String code) {
    return switch (code) {
      'pt' => AppLanguage.pt,
      'en' => AppLanguage.en,
      'es' => AppLanguage.es,
      _ => AppLanguage.en,
    };
  }

  /// Locale dinâmico para datas (intl/DateFormat).
  String get intlLocale => switch (this) {
        AppLanguage.pt => 'pt_BR',
        AppLanguage.en => 'en_US',
        AppLanguage.es => 'es_ES',
      };
}

/// Regra automática quando o usuário ainda não escolheu manualmente.
///
/// - Se o país do dispositivo é BR → português.
/// - Qualquer outro país → inglês.
/// - Espanhol fica disponível apenas via escolha manual.
AppLanguage resolveAutoLanguage() {
  final locale = PlatformDispatcher.instance.locale;
  final country = locale.countryCode?.toUpperCase();
  if (country == 'BR') return AppLanguage.pt;
  return AppLanguage.en;
}

/// Chave de persistência da escolha manual.
const _kManualLanguageKey = 'multiterapia.language.v1';

/// Notifier que controla o idioma do app.
///
/// Estratégia:
/// 1. No `build` inicial, devolve [resolveAutoLanguage] (sem aguardar IO).
/// 2. Em paralelo, carrega o `SharedPreferences` e, se houver escolha manual
///    salva, sobrescreve o estado.
/// 3. [setLanguage] persiste e atualiza imediatamente.
/// 4. [clearManualChoice] volta para o modo automático.
class LocaleNotifier extends Notifier<AppLanguage> {
  SharedPreferences? _prefs;

  @override
  AppLanguage build() {
    _loadManualChoice();
    return resolveAutoLanguage();
  }

  Future<void> _loadManualChoice() async {
    _prefs = await SharedPreferences.getInstance();
    final saved = _prefs!.getString(_kManualLanguageKey);
    if (saved != null) {
      state = AppLanguage.fromCode(saved);
    }
  }

  Future<void> setLanguage(AppLanguage lang) async {
    state = lang;
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.setString(_kManualLanguageKey, lang.languageCode);
  }

  Future<void> clearManualChoice() async {
    _prefs ??= await SharedPreferences.getInstance();
    await _prefs!.remove(_kManualLanguageKey);
    state = resolveAutoLanguage();
  }

  /// True quando o estado atual veio de uma escolha manual.
  bool get isManual {
    final saved = _prefs?.getString(_kManualLanguageKey);
    return saved != null;
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, AppLanguage>(LocaleNotifier.new);
