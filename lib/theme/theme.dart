import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColor {
  AppColor._();

  static const Color primaryBlue = Color(0xFF003EC7);
  static const Color accentCyan = Color(0xFF00E3FD);
  static const Color accentCyanText = Color(0xFF00616D);
  static const Color screenBgLight = Color(0xFFFAF8FF);
  static const Color screenBgWhite = Color(0xFFFFFFFF);
  static const Color bodyText = Color(0xFF434656);
  static const Color headingDark = Color(0xFF131B2E);
  static const Color mutedText = Color(0xFF737688);
  static const Color borderHairline = Color(0xFFC3C5D9);
  static const Color likeTeal = Color(0xFF006875);
  static const Color superLikeAmber = Color(0xFFAC4700);
  static const Color dislikeRed = Color(0xFFBA1A1A);
  static const Color white = Color(0xFFFFFFFF);
  static const Color surface = white;
  static const Color primary = primaryBlue;
  static const Color textSecondary = mutedText;
  static const Color stroke = borderHairline;
  static const Color inputBg = Color(0xFFFAF8FF);
  static const Color skillBlueBg = Color(0x1A003EC7);
  static const Color skillTealBg = Color(0x1A006875);
  static const Color skillOrangeBg = Color(0x1A853600);
  static const Color skillBlueText = Color(0xFF003EC7);
  static const Color skillTealText = Color(0xFF006875);
  static const Color skillOrangeText = Color(0xFF853600);
  static const Color glassBg = Color(0xCCFAF8FF);
  static const Color cardShadow = Color(0x0D0F172A);
  static const Color blobBlue = Color(0x99EAEDFF);
  static const Color blobCyan = Color(0x339CF0FF);
  static const Color overlayGradient = Color(0x99000000);

  static const Color bodyGrey = Color(0xFF737688);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
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
  // Material-style aliases
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
        letterSpacing: 0.6,
        color: AppColor.mutedText,
      );

  static TextStyle get captionUppercase => GoogleFonts.inter(
        fontWeight: FontWeight.w500,
        fontSize: 12,
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
          error: AppColor.error,
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppTypography.titleMedium.copyWith(
            color: AppColor.headingDark,
          ),
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
            borderSide: BorderSide(color: AppColor.stroke),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppShapes.inputRadius),
            borderSide: const BorderSide(color: AppColor.primaryBlue, width: 2),
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
            color: AppColor.mutedText,
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
