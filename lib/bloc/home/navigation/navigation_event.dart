part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateTo extends NavigationEvent {
  const NavigateTo({required this.screen});

  final Screen screen;

  @override
  List<Object> get props => [screen];
}

class NavigateToChild extends NavigationEvent {
  const NavigateToChild({
    required this.screen,
    required this.state,
  });

  final Screen screen;
  final Object state;

  @override
  List<Object> get props => [screen, state];
}

// class NavigateTo extends NavigationEvent {
//   const NavigateTo({required this.name});
//
//   final HomeScreens name;
//
//   @override
//   List<Object> get props => [name];
// }
