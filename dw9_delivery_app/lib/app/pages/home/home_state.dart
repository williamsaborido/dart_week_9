import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../models/product_model.dart';
import '../../dto/order_product_dto.dart';
part 'home_state.g.dart';

@match
enum HomeStateStatus {
  initial,
  loading,
  loaded,
  error,
}

class HomeState extends Equatable {
  final HomeStateStatus status;
  final List<ProductModel> products;
  final String? erroMessage;
  final List<OrderProductDto> shoppingBag;

  const HomeState({
    required this.status,
    required this.products,
    required this.shoppingBag,
    this.erroMessage,
  });

  const HomeState.initial()
      : status = HomeStateStatus.initial,
        products = const [],
        shoppingBag = const [],
        erroMessage = null;

  @override
  List<Object?> get props => [status, products, shoppingBag, erroMessage];

  HomeState copyWith(
      {HomeStateStatus? status,
      List<ProductModel>? products,
      List<OrderProductDto>? shoppingBag,
      String? errorMessage}) {
    return HomeState(
      status: status ?? this.status,
      products: products ?? this.products,
      shoppingBag: shoppingBag ?? this.shoppingBag,
      erroMessage: erroMessage,
    );
  }
}
