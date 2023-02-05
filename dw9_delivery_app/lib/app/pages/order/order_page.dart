import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/widgets/delivery_appbar.dart';
import '../../core/ui/styles/text_styles_app.dart';
import '../../core/ui/widgets/delivery_button.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';
import './widget/order_product_tile.dart';
import './widget/order_field.dart';
import './widget/payment_types_field.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Text(
                    'Carrinho',
                    style: context.textStyle.textTitle,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Image.asset('assets/images/trashRegular.png'),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate(childCount: 2, (context, index) {
              return Column(
                children: [
                  OrderProductTile(
                    index: index,
                    product: OrderProductDto(
                        amount: 2,
                        product: ProductModel.fromMap({
                          'id': 0,
                          'name': '',
                          'description': '',
                          'price': 0.0,
                          'image': ''
                        })),
                  ),
                ],
              );
            }),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total do pedido',
                        style: context.textStyle.textExtraBold
                            .copyWith(fontSize: 16),
                      ),
                      Text(
                        r'R$ 200,00',
                        style: context.textStyle.textExtraBold
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                const Divider(color: Colors.grey),
                const SizedBox(height: 10),
                OrderField(
                  title: 'Endereço de entrega',
                  controller: TextEditingController(),
                  validator: Validatorless.required(''),
                  hint: 'Digite o endereço',
                ),
                const SizedBox(height: 10),
                OrderField(
                  title: 'CPF',
                  controller: TextEditingController(),
                  validator: Validatorless.required(''),
                  hint: 'Digite o CPF',
                ),
                const PaymentTypesField(),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(color: Colors.grey),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: DeliveryButton(
                    width: context.screenWidth,
                    height: 48,
                    label: 'Finalizar',
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
