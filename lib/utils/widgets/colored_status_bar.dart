import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ColoredStatusBar extends StatelessWidget {
  const ColoredStatusBar(
      {super.key,
      this.color,
      this.child,
      this.brightness = Brightness.dark,
      this.safeAreaTop = true,
      this.safeAreaBottom = true});

  final Color? color;
  final Widget? child;
  final Brightness brightness;
  final bool safeAreaTop;
  final bool safeAreaBottom;

  @override
  Widget build(BuildContext context) {
    var defaultColor = Colors.white;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: color ?? defaultColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Container(
        color: color ?? defaultColor,
        child: SafeArea(
          top: safeAreaTop,
          bottom: safeAreaBottom,
          child: Container(
            child: child,
          ),
        ),
      ),
    );
  }
}
