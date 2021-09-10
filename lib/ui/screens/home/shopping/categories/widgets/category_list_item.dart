import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/home/shopping/products/products_bloc.dart';
import 'package:water/domain/model/shopping/category.dart';
import 'package:water/ui/shared_widgets/water.dart';
import 'package:water/util/localization.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.products.add(
          LoadProducts(
            categoryId: category.id,
            language: Localization.currentLanguage(context),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                AppColors.white,
                AppColors.grey,
              ],
              stops: [
                0.15,
                1.0,
              ],
              radius: 1.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: category.imageUri,
                  fadeInDuration: const Duration(milliseconds: 250),
                  fadeOutDuration: const Duration(milliseconds: 250),
                  fadeInCurve: Curves.fastOutSlowIn,
                  fadeOutCurve: Curves.fastOutSlowIn,
                ),
              ),
              const SizedBox(height: 24.0),
              WaterText(
                category.title,
                fontSize: 18.0,
                lineHeight: 1.5,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
