import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './home_controller.dart';
import './home_state.dart';
import '../../core/ui/widgets/delivery_appbar.dart';
import '../../core/ui/base_state/base_state.dart';
import '../../../app/pages/home/widgets/delivery_product_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.loadProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: BlocConsumer<HomeController, HomeState>(
          listener: (context, state) {
            state.status.matchAny(
                any: () => hideLoader(),
                loading: () => showLoader(),
                error: () {
                  hideLoader();
                  showError(state.erroMessage ?? 'Erro deesconhecido');
                });
          },
          buildWhen: (previous, current) => current.status.matchAny(
                any: () => false,
                initial: () => true,
                loaded: () => true,
              ),
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) => DeliveryProductTile(
                      product: state.products[index],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
