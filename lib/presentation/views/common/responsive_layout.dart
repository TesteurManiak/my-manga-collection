import 'package:flutter/material.dart';

const _kTabletMinWidth = 650.0;
const _kDesktopMinWidth = 1100.0;

typedef ResponsiveBuilder = Widget Function(
  BuildContext context,
  BoxConstraints constraints,
);

class ResponsiveLayout extends StatelessWidget {
  final LayoutWidgetBuilder mobile;
  final LayoutWidgetBuilder? tablet;
  final LayoutWidgetBuilder? desktop;

  const ResponsiveLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width < _kTabletMinWidth;
  }

  static bool isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width >= _kTabletMinWidth && size.width < _kDesktopMinWidth;
  }

  static bool isDesktop(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width >= _kDesktopMinWidth;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > _kDesktopMinWidth) {
          return desktop?.call(context, constraints) ??
              tablet?.call(context, constraints) ??
              mobile(context, constraints);
        } else if (constraints.maxWidth > _kTabletMinWidth) {
          return tablet?.call(context, constraints) ??
              mobile(context, constraints);
        } else {
          return mobile(context, constraints);
        }
      },
    );
  }
}
