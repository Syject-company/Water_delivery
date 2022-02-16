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

class Home extends NavigationState {
  const Home({required String title}) : super(title: title, index: 0);
}

class Categories extends Home {
  const Categories() : super(title: 'screen.categories');
}

class Products extends Home {
  const Products() : super(title: 'screen.products');
}

class Profile extends NavigationState {
  const Profile() : super(title: 'screen.profile', index: 1);
}

class Cart extends NavigationState {
  const Cart() : super(title: 'screen.cart', index: 2);
}
