import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/domain/model/home/shop/category.dart';
import 'package:water/ui/extensions/widget.dart';
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
        context.shop.add(
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFD2F4FF),
              ],
              begin: FractionalOffset(-0.33, -0.33),
              end: FractionalOffset(0.66, 0.66),
              stops: [0.0, 1.0],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: category.imageUri,
                ).withPaddingAll(12.0),
              ),
              const SizedBox(height: 24.0),
              WaterText(
                category.title,
                fontSize: 18.0,
                lineHeight: 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
