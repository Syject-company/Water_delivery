part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();
}

class LoadCategories extends ShopEvent {
  const LoadCategories({required this.language});

  final String language;

  @override
  List<Object> get props => [language];
}

class LoadProducts extends ShopEvent {
  const LoadProducts({
    required this.categoryId,
    required this.language,
  });

  final String categoryId;
  final String language;

  @override
  List<Object> get props => [categoryId, language];
}
