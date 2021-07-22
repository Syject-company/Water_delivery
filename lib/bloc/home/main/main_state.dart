part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState();
}

enum Pages {
  Categories,
  Products,
  Profile,
  ShoppingCart,
  Menu,
}

class MainInitial extends MainState {
  const MainInitial();

  @override
  List<Object> get props => [];
}
