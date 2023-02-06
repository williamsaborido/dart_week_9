import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/ui/widgets/delilvery_increment_decrement_button.dart';
import '../../../dto/order_product_dto.dart';
import '../../../core/ui/styles/text_styles_app.dart';
import '../../../core/ui/styles/colors_app.dart';
import '../../../core/extensions/formatter_extension.dart';
import '../order_controller.dart';

class OrderProductTile extends StatelessWidget {
  final int index;
  final OrderProductDto orderProduct;

  const OrderProductTile({
    Key? key,
    required this.index,
    required this.orderProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Image.network(
            orderProduct.product.image,
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
                    orderProduct.product.name,
                    style: context.textStyle.textRegular.copyWith(fontSize: 16),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (orderProduct.product.price * orderProduct.amount)
                            .currencyPTBR,
                        style: context.textStyle.textMedium.copyWith(
                          fontSize: 14,
                          color: context.colors.secondary,
                        ),
                      ),
                      DelilveryIncrementDecrementButton.compact(
                        ammount: orderProduct.amount,
                        incrementTap: () {
                          context
                              .read<OrderController>()
                              .incrementProduct(index);
                        },
                        decrementTap: () {
                          context
                              .read<OrderController>()
                              .decrementProduct(index);
                        },
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
