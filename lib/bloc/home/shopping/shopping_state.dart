part of 'shopping_bloc.dart';

abstract class ShoppingState extends Equatable {
  const ShoppingState();

  @override
  List<Object> get props => [];
}

class ShoppingInitial extends ShoppingState {
  const ShoppingInitial();
}

class ShoppingCategories extends ShoppingState {
  const ShoppingCategories();
}

class ShoppingProducts extends ShoppingState {
  const ShoppingProducts();
}
