import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './core/providers/application_binding.dart';
import './core/ui/theme/theme_config.dart';
import './pages/home/home_router.dart';
import './pages/product_detail/product_detail_router.dart';
import './pages/splash/splash_page.dart';
import './pages/register/register_router.dart';
import './pages/auth/login/login_router.dart';
import './pages/order/order_router.dart';
import './core/global/global_context.dart';
import './pages/order/order_completed_page.dart';

class Dw9DeliveryApp extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  Dw9DeliveryApp({Key? key}) : super(key: key) {
    GlobalContext.instance.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        title: 'Delivery App',
        theme: ThemeConfig.theme,
        navigatorKey: _navKey,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          '/Home': (context) => HomeRouter.page,
          '/ProductDetail': (context) => ProductDetailRouter.page,
          '/Auth/Login': (context) => LoginRouter.page,
          '/Auth/Register': (context) => RegisterRouter.page,
          '/Order': (context) => OrderRouter.page,
          '/Order/Completed': (context) => const OrderCompletedPage(),
        },
      ),
    );
  }
}
