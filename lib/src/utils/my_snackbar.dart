import 'package:allincorp/src/utils/my_colors.dart';
import 'package:flutter/material.dart';

class MySnackbar {
  static void show(BuildContext context,
      {String? text, Color? fondo, Color? colorText}) {
    FocusScope.of(context).requestFocus(FocusNode());

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          text!,
          textAlign: TextAlign.center,
          style:
              TextStyle(color: colorText, fontSize: 14, fontFamily: 'medium'),
        ),
        backgroundColor: fondo,
        duration: const Duration(seconds: 5),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: MyColors.cAzulLogin,
            style: BorderStyle.solid,
            width: 1,
          ),
          // borderRadius: BorderRadius.only(
          //   topLeft: Radius.circular(15),
          //   topRight: Radius.circular(15),
          // ),
        ),
      ),
    );
  }
}
