import 'package:flutter/material.dart';
import 'package:water/bloc/home/main/categories/categories_bloc.dart';
import 'package:water/bloc/home/main/main_bloc.dart';
import 'package:water/ui/shared_widgets/text/text.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 24.0),
        const WaterText(
          'Wallet balance: \$24',
          fontSize: 18.0,
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            children: <Widget>[
              const CategoryListItem(index: 1, path: 'assets/images/bottle_1.5l.png'),
              const CategoryListItem(
                  index: 2, path: 'assets/images/bottle_330ml.png'),
              const CategoryListItem(
                  index: 3, path: 'assets/images/bottle_500ml.png'),
              const CategoryListItem(index: 4, path: 'assets/images/mini_cup.png'),
              const CategoryListItem(
                  index: 5, path: 'assets/images/shrink_wrap_1.5l_v1.png'),
              const CategoryListItem(
                  index: 6, path: 'assets/images/shrink_wrap_500ml_v1.png'),
            ],
          ),
        ),
      ],
    );
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key? key,
    required this.index,
    required this.path,
  }) : super(key: key);

  final int index;
  final String path;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.categories.add(LoadProducts(category: ''));
        context.main.add(ChangeScreen(screen: Screen.products));
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
                  child: Image.asset(path),
                ),
              ),
              const SizedBox(height: 16.0),
              WaterText(
                'Category $index',
                fontSize: 18.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
