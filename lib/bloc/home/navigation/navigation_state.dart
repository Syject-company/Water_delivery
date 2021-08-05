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
  const ShopCategories() : super(title: 'screen.categories');
}

class ShopProducts extends Shop {
  const ShopProducts() : super(title: 'screen.products');
}

class Profile extends NavigationState {
  const Profile() : super(title: 'screen.profile', index: 1);
}

class Cart extends NavigationState {
  const Cart() : super(title: 'screen.cart', index: 2);
}

class Wallet extends NavigationState {
  const Wallet() : super(title: 'screen.wallet', index: 3);
}
