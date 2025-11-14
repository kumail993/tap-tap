import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_task/core/mocks/mocks.dart';
import 'package:tap_task/features/products/models/product_model.dart';
import 'package:tap_task/features/products/repository/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsState()) {
    on<ProductsEvent>((event, emit) {});
    on<LoadProductsEvent>(_loadProducts);
    on<SearchProductsEvent>(_searchProducts);
    on<AddProductEvent>(_addProductLocally);
  }

  Future<void> _loadProducts(
    LoadProductsEvent event,
    Emitter<ProductsState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          isLoading: true,
          products: mockProducts,
          filteredProducts: mockProducts,
        ),
      );
      final products = await ProductsRepository().fetchProducts();
      emit(
        state.copyWith(
          isLoading: false,
          products: products,
          filteredProducts: products,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          products: mockProducts,
          filteredProducts: mockProducts,
        ),
      );
    }
  }

  void _searchProducts(SearchProductsEvent event, Emitter<ProductsState> emit) {
    final filteredProducts = state.products
        .where(
          (product) =>
              product.title.toLowerCase().contains(event.query.toLowerCase()),
        )
        .toList();
    emit(state.copyWith(filteredProducts: filteredProducts));
  }

  void _addProductLocally(AddProductEvent event, Emitter<ProductsState> emit) {
    final product = ProductModel(
      id: 5,
      title: event.name,
      description: 'Ergonomic leather chair with adjustable height and tilt.',
      category: event.category,
      price: double.parse(event.price),
      discountPercentage: 10.0,
      rating: 4.8,
      stock: 15,
      brand: 'ComfortPro',
      sku: 'CP-501',
      weight: 18.0,
      dimensions: Dimensions(width: 60.0, height: 110.0, depth: 60.0),
      warrantyInformation: '2-year warranty',
      shippingInformation: 'Free shipping within 3–5 days',
      availabilityStatus: 'In stock',
      reviews: [
        ReviewModel(
          rating: 5,
          comment: 'Very comfortable!',
          date: DateTime.now().toIso8601String(),
          reviewerName: 'Alice Morgan',
          reviewerEmail: 'alice@example.com',
        ),
        ReviewModel(
          rating: 5,
          comment: 'Perfect for long work sessions.',
          date: DateTime.now().toIso8601String(),
          reviewerName: 'Daniel Price',
          reviewerEmail: 'daniel@example.com',
        ),
      ],
      returnPolicy: '30-day return policy',
      minimumOrderQuantity: 1,
      images: [
        'https://dummyjson.com/image/i/products/5/1.jpg',
        'https://dummyjson.com/image/i/products/5/2.jpg',
      ],
      thumbnail: 'https://dummyjson.com/image/i/products/5/thumbnail.jpg',
    );

    emit(
      state.copyWith(filteredProducts: [...state.filteredProducts, product]),
    );
  }
}
