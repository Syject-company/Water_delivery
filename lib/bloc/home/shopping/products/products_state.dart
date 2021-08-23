part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {
  const ProductsInitial();
}

class ProductsLoading extends ProductsState {
  const ProductsLoading({required this.navigate});

  final bool navigate;

  @override
  List<Object> get props => [navigate];
}

class ProductsLoaded extends ProductsState {
  const ProductsLoaded({
    required this.categoryId,
    required this.products,
  });

  final String categoryId;
  final List<Product> products;

  @override
  List<Object> get props => [
        categoryId,
        products,
      ];
}
