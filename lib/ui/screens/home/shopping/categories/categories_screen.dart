import 'package:animations/animations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shopping/categories/categories_bloc.dart';
import 'package:water/bloc/home/wallet/wallet_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'widgets/category_list_item.dart';
import 'widgets/category_loading_list_item.dart';
import 'widgets/shimmer.dart';

final _shimmerGradient = LinearGradient(
  colors: [
    AppColors.white.withOpacity(0.0),
    AppColors.white.withOpacity(0.33),
    AppColors.white.withOpacity(0.66),
    AppColors.white.withOpacity(0.33),
    AppColors.white.withOpacity(0.0),
  ],
  stops: [
    0.375,
    0.437,
    0.500,
    0.562,
    0.625,
  ],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  tileMode: TileMode.clamp,
);

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWalletBalanceText(),
        Expanded(
          child: BlocBuilder<CategoriesBloc, CategoriesState>(
            builder: (context, state) {
              Widget page = SizedBox.shrink();
              if (state is CategoriesLoading) {
                page = _buildCategoriesLoader();
              } else if (state is CategoriesLoaded) {
                page = _buildCategories(state);
              }

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                switchInCurve: Curves.fastOutSlowIn,
                switchOutCurve: Curves.fastOutSlowIn,
                child: page,
              );
            },
          ),
        )
      ],
    );
  }

  Widget _buildWalletBalanceText() {
    return BlocBuilder<WalletBloc, WalletState>(
      builder: (context, state) {
        return WaterText(
          'text.wallet_balance'.tr(args: [
            state.balance.toStringAsFixed(2),
          ]),
          fontSize: 18.0,
          lineHeight: 1.5,
          textAlign: TextAlign.center,
        ).withPaddingAll(24.0);
      },
    );
  }

  Widget _buildCategories(CategoriesLoaded state) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemCount: state.categories.length,
      itemBuilder: (context, index) {
        return CategoryListItem(
          key: ValueKey(state.categories[index]),
          category: state.categories[index],
        );
      },
    );
  }

  Widget _buildCategoriesLoader() {
    return Shimmer(
      linearGradient: _shimmerGradient,
      child: ShimmerLoading(
        isLoading: true,
        child: GridView.builder(
          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return CategoryLoadingListItem();
          },
        ),
      ),
    );
  }
}
