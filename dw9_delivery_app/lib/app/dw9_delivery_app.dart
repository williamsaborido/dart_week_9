import 'package:flutter/material.dart';

import './core/providers/application_binding.dart';
import './core/ui/theme/theme_config.dart';
import './pages/home/home_router.dart';
import './pages/product_detail/product_detail_router.dart';
import './pages/splash/splash_page.dart';
import './pages/register/register_router.dart';
import './pages/auth/login/login_router.dart';
import './pages/order/order_page.dart';

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
          '/ProductDetail': (context) => ProductDetailRouter.page,
          '/Auth/Login': (context) => LoginRouter.page,
          '/Auth/Register': (context) => RegisterRouter.page,
          '/Order': (context) => const OrderPage(),
        },
      ),
    );
  }
}
