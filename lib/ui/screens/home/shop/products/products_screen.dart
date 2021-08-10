import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';

import 'widgets/product_list_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 24.0),
        Expanded(child: _buildProducts(context)),
      ],
    );
  }

  Widget _buildProducts(BuildContext context) {
    final products = (context.shop.state as ProductsLoaded).products;

    return AnimationLimiter(
      child: GridView.builder(
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
          return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 2,
            child: SlideAnimation(
              duration: const Duration(milliseconds: 375),
              curve: Curves.fastOutSlowIn,
              child: FadeInAnimation(
                duration: const Duration(milliseconds: 375),
                curve: Curves.fastOutSlowIn,
                child: ProductListItem(
                  key: ValueKey(products[index]),
                  product: products[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
