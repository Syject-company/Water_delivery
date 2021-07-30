part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class CategoriesLoaded extends ShopState {
  const CategoriesLoaded({required this.categories});

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

class ProductsLoaded extends ShopState {
  const ProductsLoaded({required this.products});

  final List<Product> products;

  @override
  List<Object> get props => [products];
}
