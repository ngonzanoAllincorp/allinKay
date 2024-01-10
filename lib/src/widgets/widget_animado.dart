import 'package:flutter/material.dart';

class WidgetAnimado extends StatelessWidget {
  const WidgetAnimado(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 2000),
      this.ejeX = 100.0,
      this.ejeY = 0})
      : super(key: key);

  final Widget child;
  final Duration duration;
  final double ejeX;
  final double ejeY;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.fastLinearToSlowEaseIn,
      builder: (BuildContext context, Object? value, Widget? child) {
        value as double;
        return Transform(
          transform: Matrix4.identity()
            ..translate(ejeX * value, ejeY * value, 100),
          child: child!,
        );
      },
      duration: duration,
      tween: Tween(begin: 1, end: 0),
      child: child,
    );
  }
}
