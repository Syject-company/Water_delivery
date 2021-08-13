import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'widgets/category_list_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWalletBalanceText(),
        _buildCategories(context),
      ],
    );
  }

  Widget _buildWalletBalanceText() {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return WaterText(
          'text.wallet_balance'.tr(args: [state.balance.toStringAsFixed(2)]),
          fontSize: 18.0,
          lineHeight: 1.5,
          textAlign: TextAlign.center,
        ).withPaddingAll(24.0);
      },
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = (context.shop.state as CategoriesLoaded).categories;

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return CategoryListItem(
            key: ValueKey(categories[index]),
            category: categories[index],
          );
        },
      ),
    );
  }
}
