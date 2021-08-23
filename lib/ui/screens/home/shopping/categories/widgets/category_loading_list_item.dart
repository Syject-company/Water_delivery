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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Center(
                child: Icon(
                  AppIcons.placeholder,
                  color: AppColors.white,
                  size: 80.0,
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            Container(
              height: 18.0,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(9.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
