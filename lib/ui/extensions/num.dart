import 'package:water/main.dart';

extension SizeUtils on num {
  double get w {
    return (this / 100) * ResponsiveUtils.mediaQuery.size.width;
  }

  double get h {
    return (this / 100) * ResponsiveUtils.mediaQuery.size.height;
  }
}
