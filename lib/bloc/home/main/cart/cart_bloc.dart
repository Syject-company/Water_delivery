import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/domain/model/home/cart_item.dart';
import 'package:water/domain/model/home/sale.dart';
import 'package:water/domain/model/home/shop_item.dart';

part 'cart_event.dart';
part 'cart_state.dart';

extension BlocGetter on BuildContext {
  CartBloc get cart => this.read<CartBloc>();
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(CartState(
          cartItems: _cartItems,
          totalPrice: _calculateTotalPrice(_cartItems),
        ));

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is ChangeShopItemAmount) {
      yield* _mapChangeShopItemAmountToState(event);
    } else if (event is RemoveFromCart) {
      yield* _mapRemoveFromCartToState(event);
    }
  }

  Stream<CartState> _mapChangeShopItemAmountToState(
    ChangeShopItemAmount event,
  ) async* {
    final updatedCartItems = state.cartItems
        .map((cartItem) => cartItem.item.id == event.id
            ? cartItem.copyWith(amount: event.amount)
            : cartItem)
        .toList();

    yield state.copyWith(
      cartItems: updatedCartItems,
      totalPrice: _calculateTotalPrice(updatedCartItems),
    );
  }

  Stream<CartState> _mapRemoveFromCartToState(
    RemoveFromCart event,
  ) async* {
    final removedCartItems = state.cartItems
        .where((cartItem) => cartItem.item.id != event.id)
        .toList();

    yield state.copyWith(
      cartItems: removedCartItems,
      totalPrice: _calculateTotalPrice(removedCartItems),
    );
  }
}

double _calculateTotalPrice(List<CartItem> cartItems) {
  double totalPrice = 0.0;

  cartItems.forEach((cartItem) {
    final sale = cartItem.item.sale;
    final discount = sale != null ? sale.percent : 0.0;
    final price = cartItem.item.price * cartItem.amount;
    totalPrice += price - (price * discount);
  });

  return totalPrice;
}

const List<CartItem> _cartItems = [
  CartItem(
    item: ShopItem(
      id: '1',
      imageUri: 'assets/images/bottle_1.5l.png',
      price: 15.0,
      volume: 1.5,
      categoryId: '',
      sale: Sale(
        id: '1',
        title: 'Title',
        percent: 0.35,
        description: 'Description',
      ),
      title: 'Buxton Pure Lite',
      description: 'Description',
    ),
    amount: 2,
  ),
  CartItem(
    item: ShopItem(
      id: '2',
      imageUri: 'assets/images/bottle_500ml.png',
      price: 25.0,
      volume: 0.5,
      categoryId: '',
      title: 'Buxton Pure Lite',
      description: 'Description',
    ),
    amount: 7,
  ),
  CartItem(
    item: ShopItem(
      id: '3',
      imageUri: 'assets/images/bottle_330ml.png',
      price: 35.0,
      volume: 0.33,
      categoryId: '',
      sale: Sale(
        id: '1',
        title: 'Title',
        percent: 0.15,
        description: 'Description',
      ),
      title: 'Buxton Pure Lite Buxton Pure Lite',
      description: 'Description',
    ),
    amount: 1,
  ),
  CartItem(
    item: ShopItem(
      id: '4',
      imageUri: 'assets/images/mini_cup.png',
      price: 45.0,
      volume: 0.25,
      categoryId: '',
      title: 'Buxton Pure Lite Buxton Pure Lite Buxton Pure Lite',
      description: 'Description',
    ),
    amount: 4,
  ),
];
