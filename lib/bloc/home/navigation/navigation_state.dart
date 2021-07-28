part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  const NavigationState({
    required this.screens,
    required this.selectedScreen,
  });

  final List<_Screen> screens;
  final _Screen selectedScreen;

  NavigationState copyWith({
    List<_Screen>? screens,
    _Screen? selectedScreen,
  }) =>
      NavigationState(
        screens: screens ?? this.screens,
        selectedScreen: selectedScreen ?? this.selectedScreen,
      );

  @override
  List<Object> get props => [screens, selectedScreen];
}
