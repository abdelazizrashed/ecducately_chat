import 'package:educately_chat/config/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: AppColors.scaffold,
      fontFamily: 'Inter',
      // brightness: AppColors.brightness,
      inputDecorationTheme: _inputDecorationTheme,
      textTheme: _textTheme,
      iconTheme: IconThemeData(
        color: AppColors.text,
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: _inputDecorationTheme,
        // menuStyle: MenuStyle()
      ),
      appBarTheme: AppBarTheme(
        color: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.text,
          fontWeight: FontWeight.w500,
          fontSize: 20,
        ),
        iconTheme: IconThemeData(
          color: AppColors.text,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE43651),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            textStyle: const TextStyle(
          color: Color(0xFFE43651),
        )),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(elevation: 0));
}

TextTheme get _textTheme => TextTheme(
      displayLarge: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      displayMedium: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      displaySmall: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      headlineMedium: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      headlineSmall: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      titleLarge: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      titleMedium: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      bodyLarge: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      bodyMedium: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
      bodySmall: TextStyle(
        color: AppColors.text,
        fontWeight: FontWeight.normal,
        fontSize: 8,
      ),
    );
InputDecoration get searchInputDecoration => InputDecoration(
      filled: false,
      fillColor: Colors.transparent,
      labelStyle: TextStyle(
        color: AppColors.subtext,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      hintStyle: TextStyle(
        color: AppColors.subtext,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        // borderSide: BorderSide(
        //   color: AppColors.border,
        // ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        // borderSide: BorderSide(
        //   color: AppColors.border,
        // ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.blue,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    );

InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
      filled: true,
      // fillColor: AppColors.background,
      labelStyle: TextStyle(
        color: AppColors.subtext,
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      hintStyle: TextStyle(
        color: AppColors.subtext,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );

//! Extensions

extension TextStyleExtension on TextStyle {
  TextStyle setColor(Color color) {
    return copyWith(color: color);
  }

  TextStyle setFontWeight(FontWeight fontWeight) {
    return copyWith(fontWeight: fontWeight);
  }
}

extension TextThemeSizeExtension on TextTheme {
  TextStyle get s36 => displayLarge!;
  TextStyle get s31 => displayMedium!.copyWith(fontSize: 31);
  TextStyle get s30 => displayMedium!.copyWith(fontSize: 30);
  TextStyle get s29 => displayMedium!.copyWith(fontSize: 29);
  TextStyle get s28 => displayMedium!.copyWith(fontSize: 28);
  TextStyle get s27 => displayMedium!.copyWith(fontSize: 27);
  TextStyle get s26 => displayMedium!.copyWith(fontSize: 26);
  TextStyle get s25 => displayMedium!.copyWith(fontSize: 25);
  TextStyle get s24 => displayMedium!;
  TextStyle get s18 => displaySmall!;
  TextStyle get s16 => headlineMedium!;
  TextStyle get s14 => headlineSmall!;
  TextStyle get s12 => bodyLarge!;
  TextStyle get s10 => bodyMedium!;
  TextStyle get s9 => bodySmall!.copyWith(fontSize: 9);
  TextStyle get s8 => bodySmall!;

  TextStyle get topBarHeading => s18.w600;
  TextStyle get screenHeading => s16.w600;
  TextStyle get buttonText => s14.w400;
  TextStyle get subText => s12.w400.setColor(AppColors.subtext);
}

extension TextThemeWeightExtension on TextStyle {
  TextStyle get w100 => setFontWeight(FontWeight.w100);
  TextStyle get w200 => setFontWeight(FontWeight.w200);
  TextStyle get w300 => setFontWeight(FontWeight.w300);
  TextStyle get w400 => setFontWeight(FontWeight.w400);
  TextStyle get w500 => setFontWeight(FontWeight.w500);
  TextStyle get w600 => setFontWeight(FontWeight.w600);
  TextStyle get w700 => setFontWeight(FontWeight.w700);
  TextStyle get w800 => setFontWeight(FontWeight.w800);
  TextStyle get w900 => setFontWeight(FontWeight.w900);
}

extension ContextStyleExtentions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

List<BoxShadow> get defaultShadow => [
      BoxShadow(
        color: Colors.grey.withOpacity(0.08),
        blurRadius: 3,
        spreadRadius: 0,
        offset: const Offset(0, 5),
      )
    ];
