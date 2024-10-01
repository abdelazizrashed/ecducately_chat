import 'dart:math';

import 'package:educately_chat/globals.dart';
import 'package:flutter/cupertino.dart';

/// The height of the design document you are following, so you can choose the
/// same values as the design document and still be responsive.
const defaultHeight = 844.0;

/// The width of the design document you are following, so you can choose the
/// same values as the design document and still be responsive.
const defaultWidth = 393.0;

/// Get normalized height
double getHeight(BuildContext context, num height) {
  return MediaQuery.of(context).size.height * height / defaultHeight;
}

/// Get normalized width
double getWidth(BuildContext context, num width) {
  return MediaQuery.of(context).size.width * width / defaultWidth;
}

/// Get normalized height
double getHeightFraction(BuildContext context, num fraction) {
  return MediaQuery.of(context).size.height * fraction;
}

double getWidthFraction(BuildContext context, num fraction) {
  return MediaQuery.of(context).size.width * fraction;
}

/// These are extensions to use after dimension numbers to normaliz them.
extension SizeExtension on num {
  double get h => getHeight(navigatorKey.currentContext!, this);
  double get w => getWidth(navigatorKey.currentContext!, this);
  double get r => min(h, w);
}

extension ContextSizeExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
