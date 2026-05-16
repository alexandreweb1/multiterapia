import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../l10n/generated/app_localizations.dart';
import '../providers/locale_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final current = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(t.settingsTitle),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          children: [
            // ── Seção: Idioma ──────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.translate, color: MtColors.teal, size: 20),
                const SizedBox(width: 10),
                Text(
                  t.settingsLanguage,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              t.settingsLanguageDesc,
              style: const TextStyle(color: MtColors.muted, fontSize: 13),
            ),
            const SizedBox(height: 14),

            _LanguageOption(
              flag: '🇧🇷',
              label: t.languagePt,
              selected: current == AppLanguage.pt,
              onTap: () =>
                  ref.read(localeProvider.notifier).setLanguage(AppLanguage.pt),
            ),
            const SizedBox(height: 10),
            _LanguageOption(
              flag: '🇺🇸',
              label: t.languageEn,
              selected: current == AppLanguage.en,
              onTap: () =>
                  ref.read(localeProvider.notifier).setLanguage(AppLanguage.en),
            ),
            const SizedBox(height: 10),
            _LanguageOption(
              flag: '🇪🇸',
              label: t.languageEs,
              selected: current == AppLanguage.es,
              onTap: () =>
                  ref.read(localeProvider.notifier).setLanguage(AppLanguage.es),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: MtColors.tealLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      color: MtColors.teal, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      t.settingsLanguageAutoNote,
                      style: const TextStyle(
                          color: MtColors.teal, fontSize: 12, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String flag;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.flag,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? MtColors.tealLight : MtColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: selected ? MtColors.teal : MtColors.border,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Text(flag, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        selected ? FontWeight.w600 : FontWeight.w500,
                    color: selected ? MtColors.teal : MtColors.ink,
                  ),
                ),
              ),
              if (selected)
                const Icon(Icons.check_circle,
                    color: MtColors.teal, size: 22)
              else
                const Icon(Icons.radio_button_unchecked,
                    color: MtColors.muted, size: 22),
            ],
          ),
        ),
      ),
    );
  }
}
