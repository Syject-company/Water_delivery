part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}

class Shop extends NavigationState {
  const Shop({required String title}) : super(title: title);
}

class ShopCategories extends Shop {
  const ShopCategories() : super(title: 'Categories');
}

class ShopProducts extends Shop {
  const ShopProducts() : super(title: 'Products');
}

class Profile extends NavigationState {
  const Profile() : super(title: 'Profile');
}

class Cart extends NavigationState {
  const Cart() : super(title: 'Cart');
}

class Wallet extends NavigationState {
  const Wallet() : super(title: 'Wallet');
}