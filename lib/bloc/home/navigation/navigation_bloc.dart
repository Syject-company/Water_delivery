import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shopping/shopping_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

extension BlocGetter on BuildContext {
  NavigationBloc get navigation => this.read<NavigationBloc>();
}

enum Screen {
  home,
  profile,
  cart,
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({required ShoppingBloc shoppingBloc})
      : _shoppingBloc = shoppingBloc,
        super(Categories()) {
    _shoppingStateSubscription = shoppingBloc.stream.listen((state) {
      add(NavigateToChild(screen: Screen.home, state: state));
    });
  }

  late final StreamSubscription _shoppingStateSubscription;

  final ShoppingBloc _shoppingBloc;

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is BackPressed) {
      yield* _mapBackPressedToState();
    } else if (event is NavigateTo) {
      yield* _mapNavigateToToState(event);
    } else if (event is NavigateToChild) {
      yield* _mapNavigateToChildToState(event);
    }
  }

  @override
  Future<void> close() {
    _shoppingStateSubscription.cancel();
    return super.close();
  }

  Stream<NavigationState> _mapBackPressedToState() async* {
    if (_shoppingBloc.state is ShoppingProducts) {
      _shoppingBloc.add(OpenCategories());
    }
  }

  Stream<NavigationState> _mapNavigateToToState(
    NavigateTo event,
  ) async* {
    if (event.screen == Screen.home) {
      if (_shoppingBloc.state is ShoppingCategories) {
        yield Categories();
      } else if (_shoppingBloc.state is ShoppingProducts) {
        yield Products();
      }
    } else if (event.screen == Screen.profile) {
      yield Profile();
    } else if (event.screen == Screen.cart) {
      yield Cart();
    }
  }

  Stream<NavigationState> _mapNavigateToChildToState(
    NavigateToChild event,
  ) async* {
    if (event.screen == Screen.home) {
      if (event.state is ShoppingCategories) {
        yield Categories();
      } else if (event.state is ShoppingProducts) {
        yield Products();
      }
    }
  }
}
