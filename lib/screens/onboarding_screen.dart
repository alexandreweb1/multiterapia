import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../l10n/generated/app_localizations.dart';
import '../models/user_model.dart';
import '../widgets/brand_mark.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';

/// Tela 01 — Onboarding: hero teal com marca, card de seleção de perfil.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: MtColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // ── Hero teal ────────────────────────────────────────────
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: MtColors.teal,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const BrandMark(size: 88, onDark: true),
                    const SizedBox(height: 24),
                    const Text(
                      'multiterapia',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      t.appTagline,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Card "Como você quer entrar?" ────────────────────────
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: MtColors.surfaceCard,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: MtColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      t.onboardingHowToEnter,
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.onboardingChooseProfile,
                      style: TextStyle(
                          color: MtColors.muted, fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    _RoleTile(
                      icon: Icons.medical_services_outlined,
                      title: t.onboardingImTherapist,
                      subtitle: t.onboardingTherapistSubtitle,
                      filled: true,
                      onTap: () => _go(context, UserRole.therapist),
                    ),
                    const SizedBox(height: 12),
                    _RoleTile(
                      icon: Icons.favorite_border_rounded,
                      iconColor: MtColors.coral,
                      title: t.onboardingImPatient,
                      subtitle: t.onboardingPatientSubtitle,
                      filled: false,
                      onTap: () => _go(context, UserRole.patient),
                    ),
                    const Spacer(),
                    Center(
                      child: TextButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                        ),
                        child: Text(t.onboardingHaveAccount),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _go(BuildContext context, UserRole role) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterScreen(initialRole: role),
      ),
    );
  }
}

class _RoleTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final bool filled;
  final VoidCallback onTap;

  const _RoleTile({
    required this.icon,
    this.iconColor,
    required this.title,
    required this.subtitle,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bg = filled ? MtColors.teal : MtColors.surfaceCard;
    final fg = filled ? Colors.white : MtColors.ink;
    final muted = filled ? Colors.white.withValues(alpha: 0.85) : MtColors.muted;

    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: filled ? MtColors.teal : MtColors.border,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: iconColor ?? fg, size: 24),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: fg,
                            fontSize: 15,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(subtitle,
                        style: TextStyle(color: muted, fontSize: 12)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward, color: fg, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
