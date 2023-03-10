import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _instance;

  Color get primary => const Color(0xFF007D21);
  Color get secondary => const Color(0xFFF88B0C);

  ColorsApp._();

  static ColorsApp get instance {
    _instance ??= ColorsApp._();
    return _instance!;
  }
}

extension ColorsAppExtension on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}
