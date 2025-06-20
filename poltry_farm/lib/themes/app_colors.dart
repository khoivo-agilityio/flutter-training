import 'package:flutter/material.dart';
import 'package:poltry_farm/themes/app_palette.dart';

class PfColors {
  static ColorScheme light = ColorScheme(
    brightness: Brightness.light,
    primary: PfPalette.yellow[5]!,
    onPrimary: Colors.white,
    secondary: PfPalette.green[5]!,
    onSecondary: Colors.white,
    error: PfPalette.red[5]!,
    onError: Colors.white,
    surface: PfPalette.grey[4]!,
    onSurface: PfPalette.grey[5]!,
    onSurfaceVariant: PfPalette.grey[10],
    outline: PfPalette.grey[2]!,
    surfaceContainer: PfPalette.grey[3]!,
  );
}
