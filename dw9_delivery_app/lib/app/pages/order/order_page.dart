import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/extensions/formatter_extension.dart';
import '../../models/payment_type_model.dart';
import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/delivery_appbar.dart';
import '../../core/ui/styles/text_styles_app.dart';
import '../../core/ui/widgets/delivery_button.dart';
import '../../core/ui/helpers/size_extensions.dart';
import '../../dto/order_product_dto.dart';
import './widget/order_product_tile.dart';
import './widget/order_field.dart';
import './widget/payment_types_field.dart';
import './order_controller.dart';
import './order_state.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController enderecoControler = TextEditingController();
  final TextEditingController cpfControler = TextEditingController();
  int? paymentTypeId;
  final paymentTypeValid = ValueNotifier<bool>(true);

  @override
  void onReady() {
    super.onReady();

    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;

    controller.load(products);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            loaded: () => hideLoader(),
            error: () {
              hideLoader();
              showError(state.erroMessage ?? 'Erro não informado');
            },
            confirmRemoveProduct: () {
              hideLoader();
              if (state is OrderConfirmDeleteProductState) {
                _showConfirmProductDialog(state);
              }
            },
            emptyBag: () {
              showInfo(
                  'Sua sacola está vazia, por favor, selecione um produto para realizar seu pedido');
              Navigator.pop(context, <OrderProductDto>[]);
            },
            success: () {
              hideLoader();
              Navigator.of(context).popAndPushNamed(
                '/Order/Completed',
                result: <OrderProductDto>[],
              );
            });
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.orderProducts);
          return false;
        },
        child: Scaffold(
          appBar: DeliveryAppbar(),
          body: Form(
            key: _formKey,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Text(
                          'Carrinho',
                          style: context.textStyle.textTitle,
                        ),
                        IconButton(
                          icon: Image.asset('assets/images/trashRegular.png'),
                          onPressed: () => controller.emptyBag(),
                        ),
                      ],
                    ),
                  ),
                ),
                BlocSelector<OrderController, OrderState,
                    List<OrderProductDto>>(
                  selector: (state) => state.orderProducts,
                  builder: (context, orderProducts) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: orderProducts.length,
                        (context, index) {
                          final orderProduct = orderProducts[index];
                          return Column(
                            children: [
                              OrderProductTile(
                                index: index,
                                orderProduct: orderProduct,
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
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
                            BlocSelector<OrderController, OrderState, double>(
                              selector: (state) => state.totalOrder,
                              builder: (context, totalOrder) {
                                return Text(
                                  totalOrder.currencyPTBR,
                                  style: context.textStyle.textExtraBold
                                      .copyWith(fontSize: 20),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(color: Colors.grey),
                      const SizedBox(height: 10),
                      OrderField(
                        title: 'Endereço de entrega',
                        controller: enderecoControler,
                        validator: Validatorless.required(
                            'Endereço de entrega obrigatório'),
                        hint: 'Digite o endereço',
                      ),
                      const SizedBox(height: 10),
                      OrderField(
                        title: 'CPF',
                        controller: cpfControler,
                        validator: Validatorless.required('CPF obrigatório'),
                        hint: 'Digite o CPF',
                      ),
                      const SizedBox(height: 20),
                      BlocSelector<OrderController, OrderState,
                          List<PaymentTypeModel>>(
                        selector: (state) => state.paymentTypes,
                        builder: (context, paymentTypes) {
                          return ValueListenableBuilder(
                            valueListenable: paymentTypeValid,
                            builder: (_, paymentTypeValidValue, child) {
                              return PaymentTypesField(
                                paymentTypes: paymentTypes,
                                valueSelected: paymentTypeId.toString(),
                                valid: paymentTypeValidValue,
                                valueChanged: (value) {
                                  paymentTypeId = value;
                                },
                              );
                            },
                          );
                        },
                      ),
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
                          onPressed: () {
                            final valid =
                                _formKey.currentState?.validate() ?? false;

                            final paymentTypeSelected = paymentTypeId != null;
                            paymentTypeValid.value = paymentTypeSelected;

                            if (valid && paymentTypeSelected) {
                              controller.saveOrder(
                                address: enderecoControler.text,
                                document: cpfControler.text,
                                paymentMethodId: paymentTypeId!,
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmProductDialog(OrderConfirmDeleteProductState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
              'Deseja excluir o produto ${state.orderProduct.product.name}'),
          actions: [
            TextButton(
              onPressed: () {
                controller.cancelDeleteProcess();
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: context.textStyle.textBold
                    .copyWith(color: const Color(0xFFFF0000)),
              ),
            ),
            TextButton(
              onPressed: () {
                controller.decrementProduct(state.index);
                Navigator.of(context).pop();
              },
              child: Text(
                'Confirmar',
                style: context.textStyle.textBold,
              ),
            ),
          ],
        );
      },
    );
  }
}
