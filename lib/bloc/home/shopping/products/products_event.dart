part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductsEvent {
  const LoadProducts({
    required this.categoryId,
    required this.language,
    this.navigate = true,
  });

  final String categoryId;
  final String language;
  final bool navigate;

  @override
  List<Object> get props => [categoryId, language];
}
