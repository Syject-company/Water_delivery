import 'package:flutter/material.dart';
import 'package:water/ui/constants/colors.dart';
import 'package:water/ui/extensions/widget.dart';

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
              child: CustomPaint(
                size: Size(39, 128),
                painter: BottlePainter(),
              ).withPaddingAll(12.0),
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

class BottlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 0.9807692, size.height * 0.9203125);
    path.cubicTo(
      size.width * 1.017949,
      size.height * 0.8304687,
      size.width,
      size.height * 0.7394531,
      size.width * 0.9269231,
      size.height * 0.6519531,
    );
    path.cubicTo(
      size.width * 0.9051282,
      size.height * 0.6253906,
      size.width * 0.9012821,
      size.height * 0.5980469,
      size.width * 0.9166667,
      size.height * 0.5710937,
    );
    path.lineTo(size.width * 0.9833333, size.height * 0.4613281);
    path.lineTo(size.width * 0.9833333, size.height * 0.2574219);
    path.cubicTo(
      size.width * 0.9615385,
      size.height * 0.1847656,
      size.width * 0.8423077,
      size.height * 0.1183594,
      size.width * 0.6512821,
      size.height * 0.07343750,
    );
    path.lineTo(size.width * 0.6512821, size.height * 0.05703125);
    path.cubicTo(
      size.width * 0.6538462,
      size.height * 0.05703125,
      size.width * 0.6564103,
      size.height * 0.05703125,
      size.width * 0.6576923,
      size.height * 0.05664063,
    );
    path.lineTo(size.width * 0.6576923, size.height * 0.05664063);
    path.lineTo(size.width * 0.6589744, size.height * 0.05664063);
    path.cubicTo(
      size.width * 0.6589744,
      size.height * 0.05664063,
      size.width * 0.6602564,
      size.height * 0.05664063,
      size.width * 0.6602564,
      size.height * 0.05625000,
    );
    path.lineTo(size.width * 0.6653846, size.height * 0.05546875);
    path.lineTo(size.width * 0.6679487, size.height * 0.05546875);
    path.lineTo(size.width * 0.6705128, size.height * 0.05468750);
    path.lineTo(size.width * 0.6730769, size.height * 0.05351563);
    path.lineTo(size.width * 0.6756410, size.height * 0.05234375);
    path.lineTo(size.width * 0.6756410, size.height * 0.05117188);
    path.lineTo(size.width * 0.6756410, size.height * 0.05117188);
    path.cubicTo(
      size.width * 0.6769231,
      size.height * 0.05039063,
      size.width * 0.6782051,
      size.height * 0.04921875,
      size.width * 0.6782051,
      size.height * 0.04804688,
    );
    path.lineTo(size.width * 0.6782051, size.height * 0.008593750);
    path.cubicTo(
      size.width * 0.6782051,
      size.height * 0.003906250,
      size.width * 0.6653846,
      0.0,
      size.width * 0.6500000,
      0.0,
    );
    path.lineTo(size.width * 0.3500000, 0);
    path.cubicTo(
      size.width * 0.3346154,
      0.0,
      size.width * 0.3217949,
      size.height * 0.003906250,
      size.width * 0.3217949,
      size.height * 0.008593750,
    );
    path.lineTo(size.width * 0.3217949, size.height * 0.04843750);
    path.cubicTo(
      size.width * 0.3217949,
      size.height * 0.05156250,
      size.width * 0.3269231,
      size.height * 0.05429687,
      size.width * 0.3346154,
      size.height * 0.05585937,
    );
    path.cubicTo(
      size.width * 0.3371795,
      size.height * 0.05664062,
      size.width * 0.3410256,
      size.height * 0.05703125,
      size.width * 0.3448718,
      size.height * 0.05742187,
    );
    path.lineTo(size.width * 0.3461538, size.height * 0.05742187);
    path.lineTo(size.width * 0.3500000, size.height * 0.05742187);
    path.lineTo(size.width * 0.3512821, size.height * 0.05742187);
    path.lineTo(size.width * 0.3512821, size.height * 0.07382812);
    path.cubicTo(
      size.width * 0.1615385,
      size.height * 0.1183594,
      size.width * 0.04102564,
      size.height * 0.1851562,
      size.width * 0.01923077,
      size.height * 0.2578125,
    );
    path.lineTo(size.width * 0.01923077, size.height * 0.4613281);
    path.lineTo(size.width * 0.08333333, size.height * 0.5710937);
    path.cubicTo(
      size.width * 0.09871795,
      size.height * 0.5980469,
      size.width * 0.09615385,
      size.height * 0.6253906,
      size.width * 0.07307692,
      size.height * 0.6519531,
    );
    path.cubicTo(
      0.0,
      size.height * 0.7394531,
      size.width * -0.01794872,
      size.height * 0.8308594,
      size.width * 0.01923077,
      size.height * 0.9203125,
    );
    path.cubicTo(
      size.width * 0.01923077,
      size.height * 0.9203125,
      size.width * -0.01538462,
      size.height * 1.010937,
      size.width * 0.5000000,
      size.height * 0.9988281,
    );
    path.cubicTo(
      size.width * 1.015385,
      size.height * 1.010938,
      size.width * 0.9807692,
      size.height * 0.9203125,
      size.width * 0.9807692,
      size.height * 0.9203125,
    );
    path.lineTo(size.width * 0.9807692, size.height * 0.9203125);
    path.close();

    Paint fill = Paint()..style = PaintingStyle.fill;
    fill.color = AppColors.white;
    canvas.drawPath(path, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
