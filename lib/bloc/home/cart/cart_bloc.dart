import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/domain/model/home/shop/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

extension BlocGetter on BuildContext {
  CartBloc get cart => this.read<CartBloc>();
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState(items: [], totalPrice: 0.0));

  CartItem? getItemById(String id) {
    return state.items.firstWhereOrNull((item) => item.product.id == id);
  }

  bool contains(Product product) {
    return getItemById(product.id) != null;
  }

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is AddToCart) {
      yield* _mapAddToCartToState(event);
    } else if (event is RemoveFromCart) {
      yield* _mapRemoveFromCartToState(event);
    }
  }

  Stream<CartState> _mapAddToCartToState(
    AddToCart event,
  ) async* {
    final List<CartItem> newItems;
    if (getItemById(event.product.id) != null) {
      newItems = state.items
          .map((cartItem) => cartItem.product.id == event.product.id
              ? cartItem.copyWith(amount: event.amount)
              : cartItem)
          .toList();
    } else {
      newItems = [
        ...state.items,
        CartItem(product: event.product, amount: event.amount),
      ];
    }

    yield state.copyWith(
      items: newItems,
      totalPrice: _calculateTotalPrice(newItems),
    );
  }

  Stream<CartState> _mapRemoveFromCartToState(
    RemoveFromCart event,
  ) async* {
    final newItems = state.items
        .where((item) => item.product.id != event.product.id)
        .toList();

    yield state.copyWith(
      items: newItems,
      totalPrice: _calculateTotalPrice(newItems),
    );
  }
}

double _calculateTotalPrice(List<CartItem> cartItems) {
  double totalPrice = 0.0;

  cartItems.forEach((cartItem) {
    final sale = cartItem.product.sale;
    final discount = sale != null ? sale.percent : 0.0;
    final price = cartItem.product.price * cartItem.amount;
    totalPrice += price - (price * discount);
  });

  return totalPrice;
}
