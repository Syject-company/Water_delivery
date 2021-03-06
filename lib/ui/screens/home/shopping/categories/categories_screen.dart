import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/auth/auth_bloc.dart';
import 'package:water/bloc/home/profile/profile_bloc.dart';
import 'package:water/bloc/home/shopping/categories/categories_bloc.dart';
import 'package:water/ui/shared_widgets/shimmer.dart';
import 'package:water/ui/shared_widgets/water.dart';

import 'widgets/category_list_item.dart';
import 'widgets/category_loading_list_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWalletBalanceText(),
        _buildItems(),
      ],
    );
  }

  Widget _buildWalletBalanceText() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        if (state is Authenticated) {
          return BlocBuilder<ProfileBloc, ProfileState>(
            builder: (_, state) {
              return WaterText(
                'text.wallet_balance'.tr(args: [
                  state.walletBalance.toStringAsFixed(2),
                ]),
                fontSize: 18.0,
                lineHeight: 1.5,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ).withPaddingAll(24.0);
            },
          );
        }
        return const SizedBox(height: 24.0);
      },
    );
  }

  Widget _buildItems() {
    return Expanded(
      child: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (_, state) {
          Widget page = _buildCategoriesLoader();
          if (state is CategoriesLoaded) {
            page = _buildCategories(state);
          }

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            reverseDuration: const Duration(milliseconds: 250),
            switchInCurve: Curves.fastOutSlowIn,
            switchOutCurve: Curves.fastOutSlowIn,
            child: page,
          );
        },
      ),
    );
  }

  Widget _buildCategories(CategoriesLoaded state) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.865,
      ),
      itemCount: state.categories.length,
      itemBuilder: (_, index) {
        return CategoryListItem(
          key: ValueKey(state.categories[index]),
          category: state.categories[index],
        );
      },
    );
  }

  Widget _buildCategoriesLoader() {
    return ShimmerLoading(
      isLoading: true,
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isMobile ? 2 : 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.865,
        ),
        itemCount: 4,
        itemBuilder: (_, __) {
          return CategoryLoadingListItem();
        },
      ),
    );
  }
}
