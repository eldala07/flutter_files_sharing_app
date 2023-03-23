import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget desktopWidget;
  final Widget? tabletWidget;
  final Widget? mobileWidget;

  const ResponsiveWidget(
      {Key? key,
      required this.desktopWidget,
      this.tabletWidget,
      this.mobileWidget})
      : super(key: key);

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= 1200) {
        return desktopWidget;
      } else if (constraints.maxWidth >= 800 && constraints.maxWidth < 1200) {
        return tabletWidget ?? desktopWidget;
      } else {
        return mobileWidget ?? desktopWidget;
      }
    });
  }
}
