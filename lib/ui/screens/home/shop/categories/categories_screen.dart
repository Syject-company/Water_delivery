import 'package:flutter/material.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

import 'widgets/category_list_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 24.0),
        const WaterText(
          'Wallet balance: \$0',
          fontSize: 18.0,
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            children: (context.shop.state as Categories)
                .categories
                .map((category) => CategoryListItem(
                      key: ValueKey(category),
                      category: category,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}
