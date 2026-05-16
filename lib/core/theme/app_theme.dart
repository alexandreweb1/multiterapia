import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Paleta da marca Multiterapia.
class MtColors {
  static const teal = Color(0xFF0F766E);
  static const tealDark = Color(0xFF0B5A55);
  static const tealLight = Color(0xFFD9EFEC);

  static const coral = Color(0xFFF97362);
  static const coralLight = Color(0xFFFCE5DF);

  static const surface = Color(0xFFF5F1EB);
  static const surfaceCard = Colors.white;
  static const border = Color(0xFFE5DFD3);

  static const ink = Color(0xFF1F2937);
  static const muted = Color(0xFF5C7B7A);

  // Tokens auxiliares para chips de especialidade
  static const fonoBg = Color(0xFFFCE5DF);
  static const fonoFg = Color(0xFFD66A5A);
  static const fisioBg = Color(0xFFD9EFEC);
  static const fisioFg = Color(0xFF0F766E);
  static const psicoBg = Color(0xFFE6E2FA);
  static const psicoFg = Color(0xFF6E5BC4);

  // Dark
  static const inkDark = Color(0xFF0E1626);
  static const surfaceDark = Color(0xFF111827);
  static const cardDark = Color(0xFF1F2937);
  static const borderDark = Color(0xFF2A3344);
  static const mutedDark = Color(0xFF8AA1A0);
}

class AppTheme {
  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: MtColors.teal,
        onPrimary: Colors.white,
        secondary: MtColors.coral,
        onSecondary: Colors.white,
        surface: MtColors.surface,
        onSurface: MtColors.ink,
        surfaceContainerHighest: MtColors.surfaceCard,
        outline: MtColors.border,
        error: Color(0xFFB3261E),
      ),
      scaffoldBackgroundColor: MtColors.surface,
      canvasColor: MtColors.surface,
    );

    return base.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
        bodyColor: MtColors.ink,
        displayColor: MtColors.ink,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: MtColors.surface,
        foregroundColor: MtColors.ink,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: MtColors.ink,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      cardTheme: CardThemeData(
        color: MtColors.surfaceCard,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: MtColors.border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MtColors.surfaceCard,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MtColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MtColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MtColors.teal, width: 1.5),
        ),
        labelStyle: GoogleFonts.poppins(
            color: MtColors.muted, fontSize: 13, fontWeight: FontWeight.w500),
        hintStyle: GoogleFonts.poppins(
            color: MtColors.muted, fontWeight: FontWeight.w400),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MtColors.teal,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          textStyle: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MtColors.ink,
          minimumSize: const Size.fromHeight(52),
          side: const BorderSide(color: MtColors.border),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          textStyle: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MtColors.coral,
          textStyle: GoogleFonts.poppins(
              fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: MtColors.surfaceCard,
        side: const BorderSide(color: MtColors.border),
        labelStyle: GoogleFonts.poppins(
            fontSize: 13, fontWeight: FontWeight.w500, color: MtColors.ink),
        secondarySelectedColor: MtColors.teal,
        secondaryLabelStyle: GoogleFonts.poppins(
            fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999)),
        padding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      ),
      iconTheme: const IconThemeData(color: MtColors.ink),
      dividerColor: MtColors.border,
    );
  }

  static ThemeData get darkTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: MtColors.teal,
        onPrimary: Colors.white,
        secondary: MtColors.coral,
        onSecondary: Colors.white,
        surface: MtColors.surfaceDark,
        onSurface: Color(0xFFE6EDED),
        surfaceContainerHighest: MtColors.cardDark,
        outline: MtColors.borderDark,
      ),
      scaffoldBackgroundColor: MtColors.surfaceDark,
      canvasColor: MtColors.surfaceDark,
    );

    return base.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme).apply(
        bodyColor: const Color(0xFFE6EDED),
        displayColor: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: MtColors.surfaceDark,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500),
      ),
      cardTheme: CardThemeData(
        color: MtColors.cardDark,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: MtColors.borderDark),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: MtColors.cardDark,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MtColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MtColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: MtColors.teal, width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MtColors.teal,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(52),
          textStyle: GoogleFonts.poppins(
              fontSize: 15, fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
      ),
    );
  }
}
