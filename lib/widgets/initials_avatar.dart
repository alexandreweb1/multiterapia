import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../models/user_model.dart';

/// Avatar circular com iniciais. Cor do background varia conforme a especialidade
/// (ou usa teal por padrão).
class InitialsAvatar extends StatelessWidget {
  final String initials;
  final double size;
  final Specialty specialty;

  const InitialsAvatar({
    super.key,
    required this.initials,
    this.size = 40,
    this.specialty = Specialty.none,
  });

  Color get _bg => switch (specialty) {
        Specialty.fono => MtColors.fonoBg,
        Specialty.fisio => MtColors.fisioBg,
        Specialty.psico => MtColors.psicoBg,
        Specialty.none => MtColors.teal,
      };

  Color get _fg => switch (specialty) {
        Specialty.fono => MtColors.fonoFg,
        Specialty.fisio => MtColors.fisioFg,
        Specialty.psico => MtColors.psicoFg,
        Specialty.none => Colors.white,
      };

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: _bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: _fg,
          fontSize: size * 0.36,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
