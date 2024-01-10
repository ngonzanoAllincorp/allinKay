import 'package:flutter/material.dart';

class ModalPersonalizado extends StatefulWidget {
  final String title;
  final String content;

  const ModalPersonalizado(
      {super.key, required this.title, required this.content});
  @override
  // ignore: library_private_types_in_public_api
  _ModalPersonalizadoState createState() => _ModalPersonalizadoState();
}

class _ModalPersonalizadoState extends State<ModalPersonalizado>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext? context, Widget? child) {
          return Opacity(
            opacity: _animation.value,
            child: Transform.scale(
              scale: _animation.value,
              child: AlertDialog(
                title: Text(widget.title),
                content: Text(widget.content),
                actions: <Widget>[
                  MaterialButton(
                    child: const Text('Cerrar'),
                    onPressed: () {
                      Navigator.of(context!).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
