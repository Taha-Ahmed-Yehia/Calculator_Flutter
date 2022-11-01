import 'package:flutter/cupertino.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    required this.desktop,
  }) : super(key: key);

  static Size renderSize(BuildContext context) => MediaQuery.of(context).size;

  static bool isMobile(double screenWidth) => screenWidth < 720;

  static bool isDesktop(double screenWidth) => !isMobile(screenWidth);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: ((context, constraints) {
      if (isMobile(constraints.maxWidth)) {
        return mobile;
      } else {
        return desktop;
      }
    }));
  }
}
