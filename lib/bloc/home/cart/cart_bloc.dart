import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/domain/model/home/shopping/product.dart';
import 'package:water/ui/extensions/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

extension BlocGetter on BuildContext {
  CartBloc get cart => this.read<CartBloc>();
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [], totalPrice: 0.0));

  CartItem? findItem(String id) {
    return state.items.firstWhereOrNull((item) => item.product.id == id);
  }

  bool contains(Product product) {
    return findItem(product.id) != null;
  }

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is AddToCart) {
      yield* _mapAddToCartToState(event);
    } else if (event is RemoveFromCart) {
      yield* _mapRemoveFromCartToState(event);
    } else if (event is ClearCart) {
      yield* _mapClearCartToState();
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
          .toList();
    } else {
      items = [
        ...state.items,
        CartItem(product: event.product, amount: event.amount),
      ];
    }

    yield state.copyWith(
      items: items,
      totalPrice: _calculateTotalPrice(items),
    );
  }

  Stream<CartState> _mapRemoveFromCartToState(
    RemoveFromCart event,
  ) async* {
    final items = state.items
        .where((item) => item.product.id != event.product.id)
        .toList();

    yield state.copyWith(
      items: items,
      totalPrice: _calculateTotalPrice(items),
    );
  }

  Stream<CartState> _mapClearCartToState() async* {
    yield state.copyWith(
      items: [],
      totalPrice: _calculateTotalPrice([]),
    );
  }
}

double _calculateTotalPrice(List<CartItem> items) {
  double totalPrice = 0.0;

  items.forEach((item) {
    totalPrice += item.totalPrice * (1.0 - item.product.discount);
  });

  return totalPrice;
}
