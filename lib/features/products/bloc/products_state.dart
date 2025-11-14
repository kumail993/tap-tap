part of 'products_bloc.dart';

class ProductsState extends Equatable {
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;
  final bool isLoading;

  const ProductsState({
    this.products = const [],
    this.isLoading = false,
    this.filteredProducts = const [],
  });

  ProductsState copyWith({
    List<ProductModel>? products,
    bool? isLoading,
    List<ProductModel>? filteredProducts,
  }) {
    return ProductsState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      filteredProducts: filteredProducts ?? this.filteredProducts,
    );
  }

  @override
  List<Object> get props => [products, isLoading, filteredProducts];
}
