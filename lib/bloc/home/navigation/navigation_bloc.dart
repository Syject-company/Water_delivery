import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

extension BlocGetter on BuildContext {
  NavigationBloc get navigation => this.read<NavigationBloc>();
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc()
      : super(NavigationState(
          screens: _screens,
          selectedScreen: _screens[0],
        ));

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigateTo) {
      yield* _mapNavigateToEventToState(event);
    }
  }

  Stream<NavigationState> _mapNavigateToEventToState(
    NavigateTo event,
  ) async* {
    yield state.copyWith(
      selectedScreen:
          state.screens.firstWhere((screen) => screen.name == event.name),
    );
  }
}

const List<_Screen> _screens = [
  _Screen(name: HomeScreens.shop, title: 'Categories', index: 0),
  _Screen(name: HomeScreens.products, title: 'Products', index: 0),
  _Screen(name: HomeScreens.profile, title: 'Profile', index: 1),
  _Screen(name: HomeScreens.cart, title: 'Cart', index: 2),
];

enum HomeScreens {
  shop,
  products,
  profile,
  cart,
}

class _Screen extends Equatable {
  const _Screen({
    required this.name,
    required this.title,
    required this.index,
  });

  final HomeScreens name;
  final String title;
  final int index;

  @override
  List<Object> get props => [
        name,
        title,
        index,
      ];
}
