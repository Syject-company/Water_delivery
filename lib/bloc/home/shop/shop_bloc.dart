import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/shop/category.dart';
import 'package:water/domain/model/home/shop/product.dart';
import 'package:water/domain/service/category_service.dart';
import 'package:water/domain/service/product_service.dart';
import 'package:water/locator.dart';

part 'shop_event.dart';
part 'shop_state.dart';

extension BlocGetter on BuildContext {
  ShopBloc get shop => this.read<ShopBloc>();
}

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitial());

  final CategoryService _categoryService = locator<CategoryService>();
  final ProductService _productService = locator<ProductService>();

  @override
  Stream<ShopState> mapEventToState(ShopEvent event) async* {
    if (event is LoadCategories) {
      yield* _mapLoadCategoriesToState(event);
    } else if (event is LoadProducts) {
      yield* _mapLoadProductsToState(event);
    }
  }

  Stream<ShopState> _mapLoadCategoriesToState(
    LoadCategories event,
  ) async* {
    print('load categories');
    yield CategoriesLoading();
    final categories = await _categoryService.getAll(event.language);
    yield CategoriesLoaded(categories: categories);
  }

  Stream<ShopState> _mapLoadProductsToState(
    LoadProducts event,
  ) async* {
    print('load products');
    yield ProductsLoading();
    final products = await _productService.getAllByCategoryId(
      event.categoryId,
      event.language,
    );
    yield ProductsLoaded(
      categoryId: event.categoryId,
      products: products,
    );
  }
}
