import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import '../../../app/core/ui/widgets/delivery_button.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ColoredBox(
        color: const Color(0xFF140E0E),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: context.screenWidth,
                child: Image.asset(
                  'assets/images/lanche.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(height: context.percentHeight(.30)),
                  Image.asset('assets/images/logo.png'),
                  const SizedBox(height: 80),
                  DeliveryButton(
                      label: 'Acessar',
                      onPressed: () {
                        Navigator.of(context).popAndPushNamed('/Home');
                      },
                      width: context.percentWidth(.60))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
