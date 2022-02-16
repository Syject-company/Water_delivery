part of 'shopping_bloc.dart';

abstract class ShoppingEvent extends Equatable {
  const ShoppingEvent();

  @override
  List<Object> get props => [];
}

class OpenCategories extends ShoppingEvent {
  const OpenCategories();
}

class OpenProducts extends ShoppingEvent {
  const OpenProducts();
}