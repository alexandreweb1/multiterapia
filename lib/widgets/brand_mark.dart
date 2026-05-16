import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/theme/app_theme.dart';

/// Mark da marca: quadrado branco com "M" + ponto coral.
/// Usado no header do login, cadastro e no card hero do onboarding.
class BrandMark extends StatelessWidget {
  final double size;
  final bool onDark;

  const BrandMark({super.key, this.size = 48, this.onDark = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: onDark ? Colors.white : MtColors.teal,
        borderRadius: BorderRadius.circular(size * 0.22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(size * 0.16),
        child: SvgPicture.asset(
          onDark
              ? 'assets/logo/multiterapia_mark_only.svg'
              : 'assets/logo/multiterapia_mark_only.svg',
          colorFilter: onDark
              ? const ColorFilter.mode(MtColors.teal, BlendMode.srcIn)
              : const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

/// Logo + wordmark. Usado em headers leves.
class BrandLockup extends StatelessWidget {
  final double markSize;
  final TextStyle? wordStyle;
  const BrandLockup({super.key, this.markSize = 28, this.wordStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        BrandMark(size: markSize),
        const SizedBox(width: 10),
        Text(
          'multiterapia',
          style: wordStyle ??
              Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: MtColors.ink,
                  ),
        ),
      ],
    );
  }
}
