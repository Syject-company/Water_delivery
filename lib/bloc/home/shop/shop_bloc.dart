import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/data/categories.dart';
import 'package:water/domain/model/home/shop/category.dart';
import 'package:water/domain/model/home/shop/product.dart';

part 'shop_event.dart';
part 'shop_state.dart';

extension BlocGetter on BuildContext {
  ShopBloc get shop => this.read<ShopBloc>();
}

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(CategoriesLoaded(categories: categories));

  @override
  Stream<ShopState> mapEventToState(ShopEvent event) async* {
    if (event is LoadCategories) {
      yield* _mapLoadCategoriesToState();
    } else if (event is LoadProducts) {
      yield* _mapLoadProductsToState(event);
    }
  }

  Stream<ShopState> _mapLoadCategoriesToState() async* {
    yield CategoriesLoaded(categories: categories);
  }

  Stream<ShopState> _mapLoadProductsToState(LoadProducts event) async* {
    yield ProductsLoaded(products: event.products);
  }
}
