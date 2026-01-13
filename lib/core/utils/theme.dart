import 'package:digify_app/core/utils/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeType {
  static const Color errorColor = Color(0xffEB5757);
  static const Color successColor = Color(0xff27AE60);
  static const Color warningColor = Color(0xffffcc00);
  static const Color textGrayColor = Color(0xff828282);
  static const Color themeGrayColor = Color(0xff828282);
  static const Color darkModeInputFieldBorderColor = Color(0xff3B3B3B);
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff000000);
  static const Color greenColor = Color(0xff00C551);
  static const Color darkThemeSwitchColor = Color(0xff3B3B3B);

  // static final primaryColor = Colors.yellow.withOpacity(0.7);
  // static final primaryColor = Colors.yellow.withOpacity(0.7);
  static final primaryColor = Color(0xFF2596be);
  // static final primaryColor = Color(0xFFc32033);
  static const secondaryColor = Color(0xffFFD7D7);
  // static const secondaryColor = Color(0xFF3A3115);

  // static const secondaryColor = Color(0xFFE58E94);

  /* ----------------------- Light Theme Colors ------------------------- */

  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: primaryColor,
    dividerColor: const Color(0xffECECEC),
    shadowColor: const Color(0xff000000),
    cardColor: const Color(0xffFFFFFF),

    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,

      tertiary: const Color(0xffeff0f4),
      onTertiary: const Color(0xffa6aebf),
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: secondaryColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xffECECEC),
      ),
    ),
    dividerTheme: const DividerThemeData(thickness: 1),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: const Color(0xff828282),
        fontSize: 14.sp,
        fontFamily: defaultFontFamily,
        fontWeight: FontWeight.w400,
        height: 1,
      ),
    ),
  );

  /* ----------------------- Dark Theme Colors ------------------------- */
  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: primaryColor,
    cardColor: const Color(0xff1A1A1A),
    dividerColor: const Color(0xff3B3B3B),
    shadowColor: const Color(0xff000000),
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      primary: primaryColor,
      secondary: secondaryColor,
      tertiary: const Color(0xffECECEC),
      brightness: Brightness.dark,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: secondaryColor),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xff202020),
      ),
    ),
    dividerTheme: const DividerThemeData(thickness: 1),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        color: const Color(0xffCCCCCC),
        fontSize: 14.sp,
        fontFamily: defaultFontFamily,
        fontWeight: FontWeight.w400,
        height: 1,
      ),
    ),
  );
}
