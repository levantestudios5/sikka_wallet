/// Creating custom color palettes is part of creating a custom app. The idea is to create
/// your class of custom colors, in this case `CompanyColors` and then create a `ThemeData`
/// object with those colors you just defined.
///
/// Resource:
/// A good resource would be this website: http://mcg.mbitson.com/
/// You simply need to put in the colour you wish to use, and it will generate all shades
/// for you. Your primary colour will be the `500` value.
///
/// Colour Creation:
/// In order to create the custom colours you need to create a `Map<int, Color>` object
/// which will have all the shade values. `const Color(0xFF...)` will be how you create
/// the colours. The six character hex code is what follows. If you wanted the colour
/// #114488 or #D39090 as primary colours in your setting, then you would have
/// `const Color(0x114488)` and `const Color(0xD39090)`, respectively.
///
/// Usage:
/// In order to use this newly created setting or even the colours in it, you would just
/// `import` this file in your project, anywhere you needed it.
/// `import 'path/to/setting.dart';`
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sikka_wallet/constants/dimens.dart';

class AppThemeData {
  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.titleMedium!.apply(color: _darkFillColor),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xFFd21e1d),
    primaryContainer: Color(0xFF9e1718),
    secondary: Color(0xFFEFF3F3),
    secondaryContainer: Color(0xFFFAFBFB),
    surface: Color(0xFFFAFBFB),
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color(0xFF6700D6),
    primaryContainer: Color(0xFF6700D6),
    secondary: Color(0xFF6700D6),
    secondaryContainer: Color(0xFF451B6F),
    surface: Color(0xFF1F1929),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const baseGradient = RadialGradient(
    colors: [
      Color(0xFFD9B5FF),
      Color(0xFFA455F8),
    ],
  );
  static const _regular = FontWeight.w400;
  static const _medium = FontWeight.w500;
  static const _semiBold = FontWeight.w600;
  static const _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headlineMedium: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 20.0),
    bodySmall: GoogleFonts.oswald(fontWeight: _semiBold, fontSize: 16.0),
    headlineSmall: GoogleFonts.oswald(fontWeight: _medium, fontSize: 16.0),
    titleMedium: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 16.0),
    labelSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 12.0),
    bodyLarge: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 14.0),
    titleSmall: GoogleFonts.montserrat(fontWeight: _medium, fontSize: 14.0),
    bodyMedium: GoogleFonts.montserrat(fontWeight: _regular, fontSize: 16.0),
    titleLarge: GoogleFonts.montserrat(fontWeight: _bold, fontSize: 16.0),
    labelLarge: GoogleFonts.montserrat(fontWeight: _semiBold, fontSize: 14.0),
  );

  static final TextStyle titleStyle = GoogleFonts.sourceSans3(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle subtitleStyle = GoogleFonts.sourceSans3(
    fontSize: 14,
    color: Colors.white,
  );

  static final TextStyle buttonTextStyle = GoogleFonts.sourceSans3(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Color(0xFF9B5DF7),
  );


  static final TextStyle linkTextStyle = GoogleFonts.sourceSans3(
    fontSize: 14,
    color: Colors.deepPurple,
    fontWeight: FontWeight.bold,
  );

  static const Color primaryColor = Color(0xFF8A2BE2);
  static const Color secondaryColor = Color(0xFF9B30FF);
  static const Color exchangeColor = Colors.purple;
  static const Color withdrawalColor = Colors.green;
  static const Color buttonColor = Color(0xFF6200EE);
  static const TextStyle buttonText = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white);
  static const TextStyle linkText = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue);



  static const TextStyle headline1 = TextStyle(
    fontSize: Dimens.appBarFontSize,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: Dimens.titleFontSize,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle bodyText = TextStyle(
    fontSize: Dimens.bodyFontSize,
    color: Colors.grey,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontSize: Dimens.bodyFontSize,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
  );

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: Dimens.paddingLarge,
      ),
    ),
  );



  static const TextStyle dateStyle = TextStyle(
    color: Colors.black87,
     fontSize: Dimens.spacingMedium,

    fontWeight: FontWeight.w300,
  );

  static const TextStyle messageStyle = TextStyle(
    fontSize: Dimens.bodyFontSize,
    fontWeight: FontWeight.bold,
  );



}
