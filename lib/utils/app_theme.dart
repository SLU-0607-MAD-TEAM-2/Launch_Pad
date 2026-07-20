import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Backward-compat aliases from old utils/app_theme.dart
class AppThemeOld {
  static const Color primaryColor = Color(0xFF0052FF);
  static const Color background = Color(0xFFF8F9FC);
  static const Color darkNeutral = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
}

class AppColor {
  AppColor._();

  // ── Core brand ────────────────────────────────────────────────────────────
  // Matches login screen exactly: #0052FF primary, Slate-based neutrals
  static const Color primaryBlue    = Color(0xFF0052FF);
  static const Color accentCyan     = Color(0xFF00C2FF);

  // ── Backgrounds ───────────────────────────────────────────────────────────
  static const Color screenBgLight  = Color(0xFFF9FAFB); // Slate-50
  static const Color screenBgWhite  = Color(0xFFFFFFFF);
  static const Color inputBg        = Color(0xFFF8FAFC); // Slate-50 variant

  // ── Text ──────────────────────────────────────────────────────────────────
  static const Color headingDark    = Color(0xFF0F172A); // Slate-900
  static const Color bodyText       = Color(0xFF475569); // Slate-600
  static const Color mutedText      = Color(0xFF64748B); // Slate-500
  static const Color placeholderText= Color(0xFF94A3B8); // Slate-400

  // ── Borders ───────────────────────────────────────────────────────────────
  static const Color borderHairline = Color(0xFFE2E8F0); // Slate-200

  // ── Surfaces ──────────────────────────────────────────────────────────────
  static const Color white          = Color(0xFFFFFFFF);
  static const Color surface        = white;
  static const Color glassBg        = Color(0xF2FFFFFF);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color error          = Color(0xFFEF4444);
  static const Color success        = Color(0xFF10B981);
  static const Color warning        = Color(0xFFF59E0B);

  // ── Aliases (backward-compat) ─────────────────────────────────────────────
  static const Color primary        = primaryBlue;
  static const Color textSecondary  = mutedText;
  static const Color stroke         = borderHairline;
  static const Color bodyGrey       = mutedText;
  static const Color cardShadow     = Color(0x0D0F172A);
  static const Color overlayGradient= Color(0x99000000);

  // ── Skill chip tints ──────────────────────────────────────────────────────
  static const Color skillBlueBg    = Color(0x1A0052FF);
  static const Color skillTealBg    = Color(0x1A006875);
  static const Color skillOrangeBg  = Color(0x1A853600);
  static const Color skillBlueText  = Color(0xFF0052FF);
  static const Color skillTealText  = Color(0xFF006875);
  static const Color skillOrangeText= Color(0xFF853600);

  // ── Legacy ────────────────────────────────────────────────────────────────
  static const Color accentCyanText = Color(0xFF00616D);
  static const Color likeTeal       = Color(0xFF006875);
  static const Color superLikeAmber = Color(0xFFAC4700);
  static const Color dislikeRed     = Color(0xFFBA1A1A);
  static const Color blobBlue       = Color(0x99EAEDFF);
  static const Color blobCyan       = Color(0x339CF0FF);
}

class AppGradients {
  static const LinearGradient accent = LinearGradient(
    colors: [AppColor.primaryBlue, AppColor.accentCyan],
  );

  static const LinearGradient screenBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAF8FF), Color(0xFFFFFFFF)],
  );

  static LinearGradient get cardImageOverlay => LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [
          AppColor.overlayGradient,
          AppColor.overlayGradient,
          Colors.transparent,
          Colors.transparent,
        ],
        stops: const [0.0, 0.3, 0.6, 1.0],
      );

  static const List<Color> cardPreset1 = [
    Color(0xFF0F2027),
    Color(0xFF203A43),
    Color(0xFF2C5364),
  ];

  static const List<Color> cardPreset2 = [
    Color(0xFF232526),
    Color(0xFF414345),
  ];

  static const List<Color> cardPreset3 = [
    Color(0xFF1A1A2E),
    Color(0xFF16213E),
    Color(0xFF0F3460),
  ];

  static const List<Color> cardPreset4 = [
    Color(0xFF4A00E0),
    Color(0xFF8E2DE2),
  ];

  static const List<List<Color>> cardPresets = [
    cardPreset1,
    cardPreset2,
    cardPreset3,
    cardPreset4,
  ];

  static const LinearGradient surface = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFFFAF8FF), Color(0xFFFFFFFF)],
  );
}

class AppTypography {
  static TextStyle get displayLarge => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w800,
        fontSize: 34,
        letterSpacing: -1,
        height: 40 / 34,
        color: AppColor.headingDark,
      );

  static TextStyle get displayMedium => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w800,
        fontSize: 28,
        letterSpacing: -0.7,
        height: 36 / 28,
        color: AppColor.headingDark,
      );

  static TextStyle get displaySmall => headingDisplay;

  static TextStyle get headlineLarge => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        height: 32 / 24,
        color: AppColor.headingDark,
      );

  static TextStyle get headlineMedium => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w700,
        fontSize: 20,
        height: 28 / 20,
        color: AppColor.headingDark,
      );

  static TextStyle get titleLarge => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        height: 28 / 22,
        color: AppColor.headingDark,
      );

  static TextStyle get titleMedium => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 24 / 16,
        color: AppColor.headingDark,
      );

  static TextStyle get labelSmall => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 11,
        height: 16 / 11,
        letterSpacing: 0.5,
        color: AppColor.bodyGrey,
      );

  static TextStyle get titleSmall => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        height: 20 / 14,
        color: AppColor.headingDark,
      );

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 24 / 16,
        color: AppColor.bodyText,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 20 / 14,
        color: AppColor.bodyText,
      );

  static TextStyle get labelLarge => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.14,
        color: AppColor.bodyText,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        letterSpacing: 0.6,
        color: AppColor.bodyText,
      );

  static TextStyle get headingDisplay => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w800,
        fontSize: 28,
        letterSpacing: -0.7,
        height: 36 / 28,
        color: AppColor.headingDark,
      );

  static TextStyle get appTitle => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w700,
        fontSize: 24,
        height: 32 / 24,
        color: AppColor.primaryBlue,
      );

  static TextStyle get cardName => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 24,
        height: 32 / 24,
        color: AppColor.white,
      );

  static TextStyle get headingSemiBold => GoogleFonts.plusJakartaSans(
        fontWeight: FontWeight.w600,
        fontSize: 18,
        height: 24 / 18,
        color: AppColor.headingDark,
      );

  static TextStyle get bodyRegular => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 24 / 16,
        color: AppColor.bodyText,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 24 / 16,
        color: AppColor.bodyText,
      );

  static TextStyle get bodySemiBold => GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        height: 24 / 16,
        color: AppColor.bodyText,
      );

  static TextStyle get label => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.14,
        color: AppColor.bodyText,
      );

  static TextStyle get labelMuted => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        letterSpacing: 0.14,
        color: AppColor.mutedText,
      );

  static TextStyle get caption => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        letterSpacing: 0.4,
        color: AppColor.mutedText,
      );

  static TextStyle get captionUppercase => GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 11,
        letterSpacing: 1.2,
        color: AppColor.mutedText,
      );

  static TextStyle get whiteBody => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 24 / 16,
        color: AppColor.white,
      );

  static TextStyle get whiteCaption => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: AppColor.white,
      );

  static TextStyle get inputLabel => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 20 / 14,
        color: AppColor.headingDark,
      );

  static TextStyle get inputText => GoogleFonts.inter(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: AppColor.headingDark,
      );

  static TextStyle get buttonLabel => GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: AppColor.white,
      );
}

class AppShapes {
  AppShapes._();

  static const double radiusMD = 12;
  static const double radiusXL = 16;
  static const double cardRadiusLarge = 32;
  static const double cardRadiusMedium = 12;
  static const double inputRadius = 8;
  static const double pillRadius = 9999;

  static BoxDecoration get cardDecoration => BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(cardRadiusLarge),
        border: Border.all(
          color: AppColor.borderHairline.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration get inputDecoration => BoxDecoration(
        color: AppColor.inputBg,
        borderRadius: BorderRadius.circular(inputRadius),
        border: Border.all(color: AppColor.borderHairline),
      );

  static BoxDecoration get authCardDecoration => BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(cardRadiusMedium),
        border: Border.all(
          color: AppColor.borderHairline.withValues(alpha: 0.3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration get primaryButtonDecoration => BoxDecoration(
        color: AppColor.primaryBlue,
        borderRadius: BorderRadius.circular(pillRadius),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryBlue.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );

  static BoxDecoration get outlinedButtonDecoration => BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(pillRadius),
        border: Border.all(color: AppColor.borderHairline),
      );

  static BoxDecoration get bottomNavDecoration => BoxDecoration(
        color: AppColor.glassBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(cardRadiusMedium),
          topRight: Radius.circular(cardRadiusMedium),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.cardShadow,
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      );
}

class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;
  static const double huge = 48;

  static const double radiusLG = 24;
  static const double radiusFull = 48;
}

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: ColorScheme.light(
          primary: AppColor.primaryBlue,
          secondary: AppColor.accentCyan,
          surface: AppColor.white,
          surfaceTint: Colors.transparent,
          error: AppColor.error,
          onSurface: AppColor.headingDark,
          onSurfaceVariant: AppColor.mutedText,
        ),
        scaffoldBackgroundColor: AppColor.screenBgLight,
        textTheme: TextTheme(
          displayLarge: AppTypography.displayLarge,
          displayMedium: AppTypography.displayMedium,
          displaySmall: AppTypography.displaySmall,
          headlineLarge: AppTypography.headlineLarge,
          headlineMedium: AppTypography.headlineMedium,
          titleLarge: AppTypography.titleLarge,
          titleMedium: AppTypography.titleMedium,
          titleSmall: AppTypography.titleSmall,
          bodyLarge: AppTypography.bodyLarge,
          bodySmall: AppTypography.bodySmall,
          labelLarge: AppTypography.labelLarge,
          labelMedium: AppTypography.labelMedium,
          labelSmall: AppTypography.labelSmall,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.screenBgLight,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTypography.titleMedium.copyWith(
            color: AppColor.headingDark,
          ),
          iconTheme: const IconThemeData(color: AppColor.headingDark),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primaryBlue,
            foregroundColor: AppColor.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xxl,
              vertical: AppSpacing.md,
            ),
            textStyle: AppTypography.buttonLabel,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColor.primaryBlue,
            side: const BorderSide(color: AppColor.stroke),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusLG),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xxl,
              vertical: AppSpacing.md,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColor.inputBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.inputRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.inputRadius),
            borderSide: const BorderSide(color: AppColor.borderHairline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.inputRadius),
            borderSide: const BorderSide(color: AppColor.primaryBlue, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.inputRadius),
            borderSide: const BorderSide(color: AppColor.error),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          hintStyle: AppTypography.bodySmall.copyWith(
            color: AppColor.placeholderText,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: AppColor.glassBg,
          elevation: 0,
          selectedItemColor: AppColor.primaryBlue,
          unselectedItemColor: AppColor.mutedText,
          type: BottomNavigationBarType.fixed,
        ),
      );
}
