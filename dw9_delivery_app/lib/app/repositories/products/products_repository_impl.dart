import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../app/core/rest_client/custom_dio.dart';
import '../../../app/models/product_model.dart';
import '../../core/exceptions/repository_exception.dart';
import './products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  final CustomDio dio;

  ProductsRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      final result = await dio.unauth().get('/products');
      return result.data
          .map<ProductModel>((json) => ProductModel.fromMap(json))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar produto', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }
}
