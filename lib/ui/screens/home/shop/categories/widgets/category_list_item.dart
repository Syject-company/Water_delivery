import 'package:flutter/material.dart';
import 'package:water/bloc/home/shop/shop_bloc.dart';
import 'package:water/domain/model/home/shop/category.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

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
          LoadProducts(products: category.products),
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
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(category.imageUri),
                ),
              ),
              const SizedBox(height: 16.0),
              WaterText(
                category.title,
                fontSize: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
