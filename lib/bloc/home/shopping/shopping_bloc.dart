import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'categories/categories_bloc.dart';
import 'products/products_bloc.dart';

part 'shopping_event.dart';
part 'shopping_state.dart';

extension BlocGetter on BuildContext {
  ShoppingBloc get shopping => this.read<ShoppingBloc>();
}

class ShoppingBloc extends Bloc<ShoppingEvent, ShoppingState> {
  ShoppingBloc({
    required CategoriesBloc categoriesBloc,
    required ProductsBloc productsBloc,
  }) : super(ShoppingInitial()) {
    _categoriesStateSubscription = categoriesBloc.stream.listen((state) {
      if (state is CategoriesLoading && state.navigate) {
        add(OpenCategories());
      }
    });
    _productsStateSubscription = productsBloc.stream.listen((state) {
      if (state is ProductsLoading && state.navigate) {
        add(OpenProducts());
      }
    });
  }

  late final StreamSubscription _categoriesStateSubscription;
  late final StreamSubscription _productsStateSubscription;

  @override
  Stream<ShoppingState> mapEventToState(
    ShoppingEvent event,
  ) async* {
    if (event is OpenCategories) {
      yield* _mapOpenCategoriesToState();
    } else if (event is OpenProducts) {
      yield* _mapOpenProductsToState();
    }
  }

  @override
  Future<void> close() {
    _categoriesStateSubscription.cancel();
    _productsStateSubscription.cancel();
    return super.close();
  }

  Stream<ShoppingState> _mapOpenCategoriesToState() async* {
    yield ShoppingCategories();
  }

  Stream<ShoppingState> _mapOpenProductsToState() async* {
    yield ShoppingProducts();
  }
}
