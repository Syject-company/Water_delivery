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

class Shopping extends NavigationState {
  const Shopping({required String title}) : super(title: title, index: 0);
}

class Categories extends Shopping {
  const Categories() : super(title: 'screen.categories');
}

class Products extends Shopping {
  const Products() : super(title: 'screen.products');
}

class Profile extends NavigationState {
  const Profile() : super(title: 'screen.profile', index: 1);
}

class Cart extends NavigationState {
  const Cart() : super(title: 'screen.cart', index: 2);
}
