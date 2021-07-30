part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class Categories extends ShopState {
  const Categories({required this.categories});

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

class Products extends ShopState {
  const Products({required this.products});

  final List<Product> products;

  @override
  List<Object> get props => [products];
}
