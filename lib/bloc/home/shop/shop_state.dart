part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {
  const ShopInitial();
}

class CategoriesLoading extends ShopState {
  const CategoriesLoading();
}

class CategoriesLoaded extends ShopState {
  const CategoriesLoaded({required this.categories});

  final List<Category> categories;

  @override
  List<Object> get props => [categories];
}

class ProductsLoading extends ShopState {
  const ProductsLoading();
}

class ProductsLoaded extends ShopState {
  const ProductsLoaded({
    required this.categoryId,
    required this.products,
  });

  final String categoryId;
  final List<Product> products;

  @override
  List<Object> get props => [categoryId, products];
}
