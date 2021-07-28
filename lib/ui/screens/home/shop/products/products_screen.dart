import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';

import 'widgets/product_list_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (_, state) {
        if (state is Products) {
          return Column(
            children: <Widget>[
              const SizedBox(height: 24.0),
              Expanded(
                child: GridView.count(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  crossAxisCount: 2,
                  childAspectRatio: 0.67,
                  children: state.products
                      .map((product) => ProductListItem(
                            key: ValueKey(product),
                            product: product,
                          ))
                      .toList(),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
