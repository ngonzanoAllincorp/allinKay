import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final String titulo;
  final IconData icon;
  final Color color;
  final Color colorLetra;
  final VoidCallback ontap;
  final String imageURL;
  const Menu({
    super.key,
    required this.titulo,
    required this.icon,
    required this.color,
    required this.ontap,
    this.imageURL = 'assets/img/mp.png',
    this.colorLetra = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        // Divider(
        //   height: 5,
        //   endIndent: 20,
        //   indent: 0,
        // ),
        InkWell(
          onTap: ontap,
          child: Container(
            height: 60,
            width: size.width,
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    imageURL,
                    width: 70,
                    height: 70,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      titulo,
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: colorLetra),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  // Spacer(),
                  Icon(
                    icon,
                    color: color,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
