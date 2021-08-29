import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:water/domain/model/cart/cart_item.dart';
import 'package:water/domain/model/cart/saved_cart_item.dart';

class ShoppingCart {
  static const String _savedCartItemsKey = 'saved_cart_items';

  static late SharedPreferences _prefs;

  static Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveItems(List<CartItem> items) async {
    final savedItems = items.map((item) {
      return SavedCartItem(id: item.product.id, amount: item.amount);
    }).toList();

    await _prefs.setString(_savedCartItemsKey, jsonEncode(savedItems));
  }

  static List<SavedCartItem> loadItems() {
    final json = _prefs.getString(_savedCartItemsKey);

    if (json != null) {
      final Iterable items = jsonDecode(json);
      return List<SavedCartItem>.from(
        items.map((item) {
          return SavedCartItem.fromJson(item);
        }),
      );
    }

    return [];
  }
}
