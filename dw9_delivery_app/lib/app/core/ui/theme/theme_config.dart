import 'package:flutter/material.dart';

import '../styles/colors_app.dart';
import '../styles/styles_app.dart';
import '../../../core/ui/styles/text_styles_app.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(7),
    borderSide: BorderSide(color: Colors.grey[400]!),
  );

  static final theme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    primaryColor: ColorsApp.instance.primary,
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.instance.primary,
      primary: ColorsApp.instance.primary,
      secondary: ColorsApp.instance.secondary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Color(0xFF000000),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: StylesApp.instance.primaryButton,
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0XFFFFFFFF),
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.all(13),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: _defaultInputBorder,
      labelStyle: TextStylesApp.instance.textRegular.copyWith(
        color: const Color(0XFF000000),
      ),
      errorStyle: TextStylesApp.instance.textRegular.copyWith(
        color: Colors.redAccent,
      ),
    ),
  );
}
