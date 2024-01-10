import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/constantes/constante.dart';
import '../src/models/user.dart';
import '../src/provider/user.dart';
import '../src/utils/get_it.dart';
import '../src/utils/shared_pref.dart';

class ValidarController {
  BuildContext? context;

  bool versionOk = true;
  Map datos = {};
  final getItProduct = getIt<UsersProvider>();
  Users? user;
  SharedPref sharedPref = SharedPref();

  Future init(BuildContext context) async {
    this.context = context;
    validarVersion(context);
  }

  void validarVersion(BuildContext context) async {
    datos = await getItProduct.versionApp();
    if (datos['mensaje'] != Constante.version) {
      String message = '';
      if (datos['mensaje'] == null) {
        message = 'Por favor verifica tu conexion a internet.';
      }

      Future(() {
        Navigator.pushNamedAndRemoveUntil(
            context, 'configuracion', (route) => false,
            arguments: message);
      });
      return;
    } else {
      verificarAcceso();
    }
  }

  void verificarAcceso() async {
    user = Users.fromJson(
      await sharedPref.read(
        'user',
        'init_roles',
      ),
    );
    if (user?.sessionToken == null) {
      Future(() {
        // Navigator.pushNamedAndRemoveUntil(context!, 'inicio', (route) => false);
        Navigator.pushNamedAndRemoveUntil(
          context!,
          'login',
          (route) => false,
        );
      });
    } else {
      // if (user!.roles!.length == 1) {
      Future(() {
        Navigator.pushNamedAndRemoveUntil(
          context!,
          'home',
          (route) => false,
          arguments: 'Validador',
        );
      });
      // } else {
      //   // Future(() {
      //   //   Navigator.pushNamedAndRemoveUntil(
      //   //     context!,
      //   //     'roles',
      //   //     (route) => false,
      //   //     arguments: 'Validador',
      //   //   );
      //   // });
      // }
    }
  }
}
