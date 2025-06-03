import 'package:flutter/material.dart';
import 'package:poltry_farm/themes/app_colors.dart';
import 'package:poltry_farm/themes/app_palette.dart';
import 'package:poltry_farm/themes/typography.dart';

class PfTheme {
  static ThemeData get light {
    final defaultTheme = ThemeData.light(
      useMaterial3: true,
    );

    return defaultTheme.copyWith(
      colorScheme: PfColors.light,
      brightness: Brightness.light,
      textTheme: _textTheme,
      inputDecorationTheme: _inputDecorationTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PfPalette.yellow[5],
          foregroundColor: Colors.white,
          textStyle: _textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  static const _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeDisplayLarge,
      fontWeight: FontWeight.w700,
      color: PfPalette.genericBlack,
    ),
    displayMedium: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeDisplayMedium,
      fontWeight: FontWeight.w700,
      color: PfPalette.genericBlack,
    ),
    displaySmall: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeDisplaySmall,
      fontWeight: FontWeight.w700,
      color: PfPalette.genericBlack,
    ),
    headlineLarge: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeHeadlineLarge,
      fontWeight: FontWeight.w700,
      color: PfPalette.genericBlack,
    ),
    headlineMedium: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeHeadlineMedium,
      fontWeight: FontWeight.w700,
      color: PfPalette.genericBlack,
    ),
    headlineSmall: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeHeadlineSmall,
      fontWeight: FontWeight.w700,
      color: PfPalette.genericBlack,
    ),
    titleLarge: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeTitleLarge,
      fontWeight: FontWeight.w400,
      color: PfPalette.genericBlack,
    ),
    titleMedium: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeTitleMedium,
      fontWeight: FontWeight.w400,
      color: PfPalette.genericBlack,
    ),
    titleSmall: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeTitleSmall,
      fontWeight: FontWeight.w400,
      color: PfPalette.genericBlack,
    ),
    labelLarge: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeLabelLarge,
      fontWeight: FontWeight.w400,
      color: PfPalette.genericBlack,
    ),
    labelMedium: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeLabelMedium,
      fontWeight: FontWeight.w400,
      color: PfPalette.genericBlack,
    ),
    labelSmall: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeLabelSmall,
      fontWeight: FontWeight.w400,
      color: PfPalette.genericBlack,
    ),
    bodyLarge: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeBodyLarge,
      fontWeight: FontWeight.w400,
      color: PfPalette.genericBlack,
    ),
    bodyMedium: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeBodyMedium,
      fontWeight: FontWeight.w400,
      color: PfPalette.genericBlack,
    ),
    bodySmall: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeBodySmall,
      fontWeight: FontWeight.w400,
      color: PfPalette.genericBlack,
    ),
  );

  static final _inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: PfPalette.grey[5],
    prefixIconColor: PfPalette.grey[5],
    suffixIconColor: PfPalette.grey[5],
    constraints: BoxConstraints.tight(
      const Size.fromHeight(40),
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 4,
    ),
    labelStyle: TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeLabelLarge,
      fontWeight: FontWeight.w400,
      height: 1.14,
      color: PfPalette.grey[4],
    ),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: PfPalette.grey[5]!,
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    floatingLabelBehavior: FloatingLabelBehavior.never,
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: PfPalette.red,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: PfPalette.red,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    errorStyle: const TextStyle(
      fontFamily: PfTypography.familyBahnschrift,
      fontSize: PfTypography.fontSizeLabelLarge,
      fontWeight: FontWeight.w400,
      height: 1.14,
      color: PfPalette.red,
    ),
  );
}
