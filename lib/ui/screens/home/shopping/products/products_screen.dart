import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shopping/products/products_bloc.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/widget.dart';
import 'package:water/ui/shared_widgets/shimmer.dart';

import 'widgets/product_list_item.dart';
import 'widgets/product_loading_list_item.dart';

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

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (_, state) {
        Widget page = SizedBox.shrink();
        if (state is ProductsLoading) {
          page = _buildProductsLoader();
        } else if (state is ProductsLoaded) {
          page = _buildProducts(state);
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          switchInCurve: Curves.fastOutSlowIn,
          switchOutCurve: Curves.fastOutSlowIn,
          child: page,
        );
      },
    ).withPadding(0.0, 24.0, 0.0, 0.0);
  }

  Widget _buildProducts(ProductsLoaded state) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.67,
      ),
      itemCount: state.products.length,
      itemBuilder: (_, index) {
        return ProductListItem(
          key: ValueKey(state.products[index]),
          product: state.products[index],
        );
      },
    );
  }

  Widget _buildProductsLoader() {
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
            childAspectRatio: 0.67,
          ),
          itemCount: 10,
          itemBuilder: (_, __) {
            return ProductLoadingListItem();
          },
        ),
      ),
    );
  }
}
