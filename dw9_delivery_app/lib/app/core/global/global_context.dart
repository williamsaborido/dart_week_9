import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class GlobalContext {
  static GlobalContext? _instance;

  late final GlobalKey<NavigatorState> _navigatorKey;

  GlobalContext._();
  static GlobalContext get instance {
    _instance ??= GlobalContext._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;

  Future<void> loginExpire() async {
    log('Called loginExpire');
    final sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();

    showTopSnackBar(
      _navigatorKey.currentState!.overlay!,
      const CustomSnackBar.error(
        message: 'Login expirado, clique na sacola novamente',
        backgroundColor: Color(0xFF000000),
      ),
    );

    _navigatorKey.currentState!.popUntil(ModalRoute.withName('/Home'));
  }
}
