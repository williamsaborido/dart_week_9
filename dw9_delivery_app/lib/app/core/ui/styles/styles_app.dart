import 'package:flutter/material.dart';

import '../../../core/ui/styles/colors_app.dart';
import '../../../core/ui/styles/text_styles_app.dart';

class StylesApp {
  static StylesApp? _instance;

  StylesApp._();

  static StylesApp get instance {
    _instance ??= StylesApp._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        backgroundColor: ColorsApp.instance.primary,
        textStyle: TextStylesApp.instance.textButtonLabel,
      );
}

extension StylesAppExtension on BuildContext {
  StylesApp get appStyle => StylesApp.instance;
}
