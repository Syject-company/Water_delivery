import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/shopping/product.dart';
import 'package:water/domain/service/product_service.dart';
import 'package:water/locator.dart';

part 'products_event.dart';
part 'products_state.dart';

extension BlocGetter on BuildContext {
  ProductsBloc get products => this.read<ProductsBloc>();
}

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial());

  final ProductService _productService = locator<ProductService>();

  Map<String, List<Product>> _cachedProducts = {};

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is LoadProducts) {
      yield* _mapLoadProductsToState(event);
    }
  }

  Stream<ProductsState> _mapLoadProductsToState(
    LoadProducts event,
  ) async* {
    print('load products');

    yield ProductsLoading(navigate: event.navigate);

    if (_cachedProducts.keys.contains(event.categoryId)) {
      final cachedProducts = _cachedProducts[event.categoryId];
      if (cachedProducts != null) {
        yield ProductsLoaded(
          categoryId: event.categoryId,
          products: cachedProducts,
        );
      }
    }

    final products = _cachedProducts[event.categoryId] =
        await _productService.getAllByCategoryId(
      event.categoryId,
      event.language,
    );
    yield ProductsLoaded(
      categoryId: event.categoryId,
      products: products,
    );
  }
}
