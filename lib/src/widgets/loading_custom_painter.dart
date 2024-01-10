import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class Loading extends StatefulWidget {
  const Loading({super.key, required this.color});
  final Color color;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  late AnimationController _controllerAnimation;
  late AnimationController _controllerAnimation2;
  late AnimationController _controllerAnimation3;
  late Animation<double> _animation1;
  late Animation<double> _animation2;
  late Animation<double> _animation3;
  @override
  void initState() {
    _controllerAnimation = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    ///
    _controllerAnimation2 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    ///
    _controllerAnimation3 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _controllerAnimation.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _controllerAnimation.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controllerAnimation.forward(from: 0.0);
        }
      },
    );
    _controllerAnimation2.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _controllerAnimation2.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controllerAnimation2.forward(from: 0.0);
        }
      },
    );
    _controllerAnimation3.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _controllerAnimation3.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controllerAnimation3.forward(from: 0.0);
        }
      },
    );

    _animation1 = Tween(
      begin: 1.1,
      end: 1.0,
    ).animate(_controllerAnimation);

    ///
    _animation2 = Tween(
      begin: 1.1,
      end: 1.0,
    ).animate(_controllerAnimation2);

    ///
    _animation3 = Tween(
      begin: 1.1,
      end: 1.0,
    ).animate(_controllerAnimation3);

    _controllerAnimation.forward();

    Future.delayed(const Duration(milliseconds: 100), () {
      _controllerAnimation2.forward(from: 0.0);
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      _controllerAnimation3.forward(from: 0.0);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controllerAnimation.dispose();
    _controllerAnimation2.dispose();
    _controllerAnimation3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: MyColors.cPri1.withOpacity(0.9),
        child: AnimatedBuilder(
          animation: _controllerAnimation2,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              painter: LoadingCustomPainter(
                  offset1: _animation1.value,
                  _animation2.value,
                  _animation3.value,
                  widget.color),
              child: Container(),
            );
          },
        ),
      ),
    );
  }
}

class LoadingCustomPainter extends CustomPainter {
  final Paint _paint;
  final double offset1;
  final double offset2;
  final double offset3;
  final Color color;
  LoadingCustomPainter(this.offset2, this.offset3, this.color,
      {required this.offset1})
      : _paint = Paint()
          ..strokeCap = StrokeCap.round
          ..color = color
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    ///
    Offset c1 = Offset(size.width * 1.7 / 4, 0.5 * size.height * (offset1));
    canvas.drawCircle(c1, 8.0, _paint);

    ///

    Offset c2 = Offset(size.width * 2 / 4, 0.5 * size.height * (offset2));
    canvas.drawCircle(c2, 8.0, _paint);

    ///
    Offset c3 = Offset(size.width * 2.3 / 4, 0.5 * size.height * (offset3));
    canvas.drawCircle(c3, 8.0, _paint);

    ///
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
