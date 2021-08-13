import 'package:flutter/material.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/extensions/widget.dart';

import 'widgets/product_list_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildProducts(context).withPadding(0.0, 24.0, 0.0, 0.0);
  }

  Widget _buildProducts(BuildContext context) {
    final products = (context.shop.state as ProductsLoaded).products;

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.67,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductListItem(
          key: ValueKey(products[index]),
          product: products[index],
        );
      },
    );
  }
}
