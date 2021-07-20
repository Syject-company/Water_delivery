import 'package:flutter/material.dart';
import 'package:water/ui/shared_widgets/text/label.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        crossAxisCount: 2,
        childAspectRatio: 260 / 330,
        children: <Widget>[
          ProductListItem(index: 1, path: 'assets/images/bottle_1.5l.png'),
          ProductListItem(index: 2, path: 'assets/images/bottle_330ml.png'),
          ProductListItem(index: 3, path: 'assets/images/bottle_500ml.png'),
          ProductListItem(index: 4, path: 'assets/images/mini_cup.png'),
          ProductListItem(
              index: 5, path: 'assets/images/shrink_wrap_1.5l_v1.png'),
          ProductListItem(
              index: 6, path: 'assets/images/shrink_wrap_500ml_v1.png'),
        ],
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    Key? key,
    required this.index,
    required this.path,
  }) : super(key: key);

  final int index;
  final String path;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18.0),
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFD2F4FF),
            ],
            begin: const FractionalOffset(-0.25, -0.25),
            end: const FractionalOffset(0.75, 0.75),
            stops: [0.0, 1.0],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Image.asset(path),
            ),
            const SizedBox(height: 16.0),
            Label('Category $index', fontSize: 18.0),
          ],
        ),
      ),
    );
  }
}
