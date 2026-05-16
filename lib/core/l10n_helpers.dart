import 'package:flutter/widgets.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/user_model.dart';

extension SpecialtyL10n on Specialty {
  String localizedLabel(BuildContext context) {
    final t = AppLocalizations.of(context);
    return switch (this) {
      Specialty.fono => t.specialtyFonoLabel,
      Specialty.fisio => t.specialtyFisioLabel,
      Specialty.psico => t.specialtyPsicoLabel,
      Specialty.none => t.specialtyNoneLabel,
    };
  }

  String localizedShort(BuildContext context) {
    final t = AppLocalizations.of(context);
    return switch (this) {
      Specialty.fono => t.specialtyFonoShort,
      Specialty.fisio => t.specialtyFisioShort,
      Specialty.psico => t.specialtyPsicoShort,
      Specialty.none => t.specialtyNoneShort,
    };
  }
}
