import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';

part 'navigation_event.dart';

part 'navigation_state.dart';

extension BlocGetter on BuildContext {
  NavigationBloc get navigation => this.read<NavigationBloc>();
}

enum Screen {
  shop,
  profile,
  cart,
}

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc({required ShopBloc shopBloc})
      : _shopBloc = shopBloc,
        super(ShopCategories()) {
    _shopStateSubscription = shopBloc.stream.listen((state) {
      add(NavigateToChild(screen: Screen.shop, state: state));
    });
  }

  late final StreamSubscription _shopStateSubscription;

  final ShopBloc _shopBloc;

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigateTo) {
      yield* _mapNavigateToToState(event);
    } else if (event is NavigateToChild) {
      yield* _mapNavigateToChildToState(event);
    }
  }

  @override
  Future<void> close() {
    _shopStateSubscription.cancel();
    return super.close();
  }

  Stream<NavigationState> _mapNavigateToToState(
    NavigateTo event,
  ) async* {
    if (event.screen == Screen.shop) {
      if (_shopBloc.state is CategoriesLoaded) {
        yield const ShopCategories();
      } else if (_shopBloc.state is ProductsLoaded) {
        yield const ShopProducts();
      }
    } else if (event.screen == Screen.profile) {
      yield const Profile();
    } else if (event.screen == Screen.cart) {
      yield const Cart();
    }
  }

  Stream<NavigationState> _mapNavigateToChildToState(
    NavigateToChild event,
  ) async* {
    if (event.screen == Screen.shop) {
      if (event.state is CategoriesLoaded) {
        yield const ShopCategories();
      } else if (event.state is ProductsLoaded) {
        yield const ShopProducts();
      }
    }
  }
}
