part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();
}

class NavigateTo extends NavigationEvent {
  const NavigateTo({required this.name});

  final HomeScreens name;

  @override
  List<Object> get props => [name];
}
