import 'package:dw9_delivery_app/app/core/providers/application_binding.dart';
import 'package:dw9_delivery_app/app/core/ui/theme/theme_config.dart';
import 'package:flutter/material.dart';

import 'pages/home/home_router.dart';
import 'pages/splash/splash_page.dart';

class Dw9DeliveryApp extends StatelessWidget {
  const Dw9DeliveryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Delivery App',
        theme: ThemeConfig.theme,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/Home': (context) => HomeRouter.page,
        },
      ),
    );
  }
}
