part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();
}

class LoadCategories extends ShopEvent {
  const LoadCategories();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ShopEvent {
  const LoadProducts({required this.products});

  final List<Product> products;

  @override
  List<Object> get props => [products];
}

class LoadProduct extends ShopEvent {
  const LoadProduct({required this.id});

  final String id;

  @override
  List<Object> get props => [id];
}
