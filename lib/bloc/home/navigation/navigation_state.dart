part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState({
    required this.title,
    required this.index,
  });

  final String title;
  final int index;

  @override
  List<Object> get props => [title, index];
}

class Shop extends NavigationState {
  const Shop({required String title}) : super(title: title, index: 0);
}

class ShopCategories extends Shop {
  const ShopCategories() : super(title: 'Categories');
}

class ShopProducts extends Shop {
  const ShopProducts() : super(title: 'Products');
}

class Profile extends NavigationState {
  const Profile() : super(title: 'Profile', index: 1);
}

class Cart extends NavigationState {
  const Cart() : super(title: 'Cart', index: 2);
}

class Wallet extends NavigationState {
  const Wallet() : super(title: 'Wallet', index: 3);
}

class Notifications extends NavigationState {
  const Notifications() : super(title: 'Notifications', index: 4);
}
