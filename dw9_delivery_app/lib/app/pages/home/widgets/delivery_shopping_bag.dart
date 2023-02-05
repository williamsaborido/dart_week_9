import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/extensions/formatter_extension.dart';
import '../../../core/ui/styles/text_styles_app.dart';
import '../../../core/ui/helpers/size_extensions.dart';
import '../../../dto/order_product_dto.dart';

class DeliveryShoppingBag extends StatelessWidget {
  final List<OrderProductDto> bag;

  const DeliveryShoppingBag({Key? key, required this.bag}) : super(key: key);

  Future<void> goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey('accessToken')) {
      final loginResult = await navigator.pushNamed('/Auth/Login');

      if (loginResult == null || loginResult == false) {
        return;
      }
    }

    await navigator.pushNamed('/Order', arguments: bag);
  }

  @override
  Widget build(BuildContext context) {
    var totalBag = bag
        .fold<double>(0, (total, order) => total += order.totalPrice)
        .currencyPTBR;

    return Container(
      width: context.screenWidth,
      height: 90,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 5),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          goOrder(context);
        },
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.shopping_cart_checkout_outlined),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Ver sacola',
                style: context.textStyle.textExtraBold.copyWith(fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                totalBag,
                style: context.textStyle.textExtraBold.copyWith(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
