import 'package:flutter/material.dart';

import '../../../core/ui/widgets/delilvery_increment_decrement_button.dart';
import '../../../dto/order_product_dto.dart';
import '../../../core/ui/styles/text_styles_app.dart';
import '../../../core/ui/styles/colors_app.dart';

class OrderProductTile extends StatelessWidget {
  final int index;
  final OrderProductDto product;

  const OrderProductTile({
    Key? key,
    required this.index,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image.network(
            'https://assets.unileversolutions.com/recipes-v2/106684.jpg?imwidth=800',
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'X-Burger',
                    style: context.textStyle.textRegular.copyWith(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        r'R$ 19,90',
                        style: context.textStyle.textMedium.copyWith(
                          fontSize: 14,
                          color: context.colors.secondary,
                        ),
                      ),
                      DelilveryIncrementDecrementButton.compact(
                        ammount: 1,
                        incrementTap: () {},
                        decrementTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
