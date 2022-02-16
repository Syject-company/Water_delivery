import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:water/bloc/home/shopping/products/products_bloc.dart';
import 'package:water/ui/shared_widgets/water.dart';

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
      buildWhen: (_, state) {
        return state is ProductsLoading || state is ProductsLoaded;
      },
      builder: (_, state) {
        Widget page = _buildProductsLoader();
        if (state is ProductsLoaded) {
          page = _buildProducts(state);
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          reverseDuration: const Duration(milliseconds: 250),
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
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 2 : 3,
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
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 2 : 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.67,
          ),
          itemCount: 12,
          itemBuilder: (_, __) {
            return ProductLoadingListItem();
          },
        ),
      ),
    );
  }
}
