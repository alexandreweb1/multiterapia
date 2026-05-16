import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';
import '../l10n/generated/app_localizations.dart';
import '../widgets/brand_mark.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: MtColors.teal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const BrandMark(size: 96, onDark: true),
            const SizedBox(height: 24),
            const Text(
              'multiterapia',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              t.splashTagline,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 36),
            const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
