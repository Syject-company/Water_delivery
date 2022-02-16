import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/cart/cart_item.dart';
import 'package:water/domain/model/shopping/product.dart';
import 'package:water/domain/services/product_service.dart';
import 'package:water/locator.dart';
import 'package:water/utils/shopping_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

extension BlocGetter on BuildContext {
  CartBloc get cart => this.read<CartBloc>();
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(
          CartState(
            items: const [],
            totalPrice: 0.0,
            vat: 0.0,
          ),
        );

  final ProductService _productService = locator<ProductService>();

  CartItem? findItem(String id) {
    return state.items.firstWhereOrNull((item) {
      return item.product.id == id;
    });
  }

  bool contains(Product product) {
    return findItem(product.id) != null;
  }

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is LoadCart) {
      yield* _mapLoadCartToState(event);
    } else if (event is AddToCart) {
      yield* _mapAddToCartToState(event);
    } else if (event is RemoveFromCart) {
      yield* _mapRemoveFromCartToState(event);
    } else if (event is ClearCart) {
      yield* _mapClearCartToState();
    }
  }

  Stream<CartState> _mapLoadCartToState(
    LoadCart event,
  ) async* {
    print('load cart');

    final savedItems = ShoppingCart.loadItems();

    if (savedItems.isNotEmpty) {
      final products = await _productService.getAll(event.language);
      final items = products
          .map((product) {
            final savedItem = savedItems.firstWhereOrNull((savedItem) {
              return savedItem.id == product.id;
            });

            if (savedItem != null) {
              return CartItem(product: product, amount: savedItem.amount);
            }
          })
          .whereNotNull()
          .toList(growable: false);

      yield state.copyWith(
        items: items,
        totalPrice: _calculateTotalPrice(items) + _calculateVAT(items),
        vat: _calculateVAT(items),
      );
    }
  }

  Stream<CartState> _mapAddToCartToState(
    AddToCart event,
  ) async* {
    final List<CartItem> items;
    if (findItem(event.product.id) != null) {
      items = state.items
          .map((item) => item.product.id == event.product.id
              ? item.copyWith(amount: event.amount)
              : item)
          .toList(growable: false);
    } else {
      items = [
        ...state.items,
        CartItem(product: event.product, amount: event.amount),
      ];
    }

    yield state.copyWith(
      items: items,
      totalPrice: _calculateTotalPrice(items) + _calculateVAT(items),
      vat: _calculateVAT(items),
    );

    ShoppingCart.saveItems(items);
  }

  Stream<CartState> _mapRemoveFromCartToState(
    RemoveFromCart event,
  ) async* {
    final items = state.items
        .where((item) => item.product.id != event.product.id)
        .toList(growable: false);

    yield state.copyWith(
      items: items,
      totalPrice: _calculateTotalPrice(items) + _calculateVAT(items),
      vat: _calculateVAT(items),
    );

    ShoppingCart.saveItems(items);
  }

  Stream<CartState> _mapClearCartToState() async* {
    final items = const <CartItem>[];

    yield state.copyWith(
      items: items,
      totalPrice: 0.0,
      vat: 0.0,
    );

    ShoppingCart.saveItems(items);
  }

  double _calculateTotalPrice(List<CartItem> items) {
    double totalPrice = 0.0;

    items.forEach((item) {
      totalPrice += item.totalPrice * (1.0 - item.product.discount);
    });

    return totalPrice;
  }

  double _calculateVAT(List<CartItem> items) {
    double vat = 0.0;

    items.forEach((item) {
      vat += item.totalPrice * (1.0 - item.product.discount);
    });

    return vat * 0.05;
  }
}
