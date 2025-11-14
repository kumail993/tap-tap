part of 'products_bloc.dart';

sealed class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends ProductsEvent {}

class SearchProductsEvent extends ProductsEvent {
  final String query;
  const SearchProductsEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class AddProductEvent extends ProductsEvent {
  final String name;
  final String category;
  final String price;
  const AddProductEvent({
    required this.name,
    required this.category,
    required this.price,
  });

  @override
  List<Object> get props => [name, category, price];
}
