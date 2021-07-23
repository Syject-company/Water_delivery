part of 'main_bloc.dart';

enum Screen {
  categories,
  products,
  profile,
  shoppingCart,
  menu,
}

class MainState extends Equatable {
  const MainState({required this.screen});

  final Screen screen;

  MainState copyWith({
    Screen? screen,
  }) =>
      MainState(screen: screen ?? this.screen);

  @override
  List<Object> get props => [screen];
}
