import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'widgets/category_list_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 24.0),
        _buildWalletBalanceText(),
        const SizedBox(height: 24.0),
        Expanded(child: _buildCategories(context)),
      ],
    );
  }

  Widget _buildWalletBalanceText() {
    return WaterText(
      'text.wallet_balance'.tr(args: ['0.00']),
      fontSize: 18.0,
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = (context.shop.state as CategoriesLoaded).categories;

    return AnimationLimiter(
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: categories.length,
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
                child: CategoryListItem(
                  key: ValueKey(categories[index]),
                  category: categories[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
