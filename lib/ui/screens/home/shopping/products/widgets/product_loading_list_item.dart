import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/water.dart';

class ProductLoadingListItem extends StatelessWidget {
  const ProductLoadingListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19.0),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Icon(
                  AppIcons.bottle,
                  color: AppColors.disabled,
                  size: 80.0,
                ),
              ).withPadding(4.0, 4.0, 4.0, 0.0),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: constraints.maxWidth * 1.0,
                        height: 15.0,
                        decoration: BoxDecoration(
                          color: AppColors.disabled,
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: constraints.maxWidth * 0.66,
                        height: 15.0,
                        decoration: BoxDecoration(
                          color: AppColors.disabled,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: constraints.maxWidth * 0.33,
                        height: 15.0,
                        decoration: BoxDecoration(
                          color: AppColors.disabled,
                          borderRadius: BorderRadius.circular(7.5),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 4.0),
            Align(
              alignment: AlignmentDirectional.bottomEnd,
              child: Container(
                width: 45.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: AppColors.disabled,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
