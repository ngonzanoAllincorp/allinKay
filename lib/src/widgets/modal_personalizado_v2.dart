import 'package:flutter/material.dart';

class ModalPersonalizadoV2 extends StatefulWidget {
  final String title;
  final Map datos;
  final List<Widget> children;

  const ModalPersonalizadoV2({
    super.key,
    required this.title,
    required this.datos,
    required this.children,
  });
  @override
  // ignore: library_private_types_in_public_api
  _ModalPersonalizadoV2State createState() => _ModalPersonalizadoV2State();
}

class _ModalPersonalizadoV2State extends State<ModalPersonalizadoV2>
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
    return Theme(
      data: ThemeData.dark(),
      child: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext? context, Widget? child) {
            return Opacity(
              opacity: _animation.value,
              child: Transform.scale(
                scale: _animation.value,
                child: AlertDialog(
                  title: Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: SizedBox(
                    width: MediaQuery.of(context!).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: widget.children,
                    ),
                  ),
                  actions: <Widget>[
                    MaterialButton(
                      child: const Text('Editar'),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'ClientPerfilPage',
                          arguments: widget.datos,
                        );
                      },
                    ),
                    MaterialButton(
                      child: const Text('Confirmar'),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          'ClientPaymentYapePage',
                          arguments: widget.datos,
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
