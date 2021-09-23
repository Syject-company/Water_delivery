import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/icons/app_icons.dart';

class CategoryLoadingListItem extends StatelessWidget {
  const CategoryLoadingListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19.0),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Center(
                child: Icon(
                  AppIcons.bottle,
                  color: AppColors.grey,
                  size: 120.0,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              height: 18.0,
              decoration: BoxDecoration(
                color: AppColors.grey,
                borderRadius: BorderRadius.circular(9.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
