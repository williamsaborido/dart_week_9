import 'package:dw9_delivery_app/app/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

import '../../core/ui/helpers/size_extensions.dart';
import '../../core/ui/styles/text_styles_app.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: context.percentHeight(.3),
              ),
              Image.asset('assets/images/logo_rounded.png'),
              const SizedBox(height: 20),
              Text(
                'Pedido realizado com sucesso, em breve você receberá a confirmação do seu pedido',
                style: context.textStyle.textExtraBold.copyWith(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              DeliveryButton(
                label: 'Fechar',
                onPressed: () => Navigator.pop(context),
                width: context.percentWidth(.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
