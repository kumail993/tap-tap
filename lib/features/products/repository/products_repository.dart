import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:tap_task/features/products/models/product_model.dart';

class ProductsRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );
  Future<List<ProductModel>> fetchProducts() async {
    log('Fetching products...');
    try {
      final response = await _dio.get('products');

      if (response.statusCode == 200) {
        log('Products fetched successfully');
        final data = response.data['products'] as List;
        return data.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        throw Exception(
          'Failed to load products. Status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      log('Dio error: ${e.message}');
      throw Exception('Dio error: ${e.message}');
    } catch (e) {
      log('Unknown error: $e');
      throw Exception('Unknown error: $e');
    }
  }
}
