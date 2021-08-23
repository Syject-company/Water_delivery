import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/shopping/product.dart';
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
