part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();
}

class ChangeScreen extends MainEvent {
  const ChangeScreen({required this.screen});

  final Screen screen;

  @override
  List<Object> get props => [screen];
}
