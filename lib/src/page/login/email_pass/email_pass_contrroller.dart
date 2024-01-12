import 'package:firebase_auth/firebase_auth.dart' as Firebase;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';
// import 'package:sn_progress_dialog/progress_dialog.dart';

import '../../../provider/user.dart';
import '../../../utils/get_it.dart';
import '../../../utils/my_colors.dart';
import '../../pages.dart';

class EmailPassController {
  late BuildContext context;
  TextEditingController correoController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController reCorreoController = TextEditingController();

  // ProgressDialog? progressDialog;
  Function? refresh;
  final getItProduct = getIt<UsersProvider>();
  String? mensajeFirebase;

  Future init(BuildContext context, Function refresh) async {
    try {
      this.context = context;
      this.refresh = refresh;
      // progressDialog = ProgressDialog(context: context);
    } catch (e) {}
  }

  bool estadoLogin = false;
  void loginEmail() async {
    try {
      estadoLogin = true;
      refresh!();
      final credential =
          await Firebase.FirebaseAuth.instance.signInWithEmailAndPassword(
        email: correoController.text,
        password: passwordController.text,
      );
      // ignore: use_build_context_synchronously
      context.read<UsersProvider>().uidEmailPass(uid: credential.user!.uid);
      Future(() {
        Navigator.pushNamedAndRemoveUntil(
          context,
          'home',
          (route) => false,
          arguments: correoController.text,
        );
      });
    } on Firebase.FirebaseAuthException catch (e) {
      estadoLogin = false;
      refresh!();
      if (e.code == 'wrong-password') {
        mensajeFirebase =
            'La contraseña no es válida o el usuario no tiene contraseña.';
        fluttertoast(mensajeFirebase!);
      } else if (e.code == 'user-not-found') {
        mensajeFirebase =
            'Ningún usuario encontrado para ese correo electrónico.';
        fluttertoast(mensajeFirebase!);
      } else if (e.code == 'unknown') {
        mensajeFirebase =
            'Por favor, completar los campos de email y contraseña.';
        fluttertoast(mensajeFirebase!);
      } else if (e.code == 'invalid-email') {
        mensajeFirebase = 'Usuario o contraseña no valida..';
        fluttertoast(mensajeFirebase!);
      } else {
        mensajeFirebase = 'Por favor contactar al administrador del App.';
        fluttertoast(mensajeFirebase!);
      }
    } catch (e) {
      // print(e);
      estadoLogin = false;
      refresh!();
      mensajeFirebase = '$e';
      fluttertoast(mensajeFirebase!);
    }
  }

  void logoutEmail() async {
    await Firebase.FirebaseAuth.instance.signOut();
  }

  void recuperarEmail() {
    try {
      Firebase.FirebaseAuth.instance
          .sendPasswordResetEmail(email: reCorreoController.text);
      Navigator.pop(context);
      displayDialogAndroid(context);
    } on Firebase.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        mensajeFirebase = 'Usuario no encontrado.';
        fluttertoast(mensajeFirebase!);
      } else if (e.code == 'invalid-email') {
        mensajeFirebase = 'El Email no cuenta con un formato valido.';
        fluttertoast(mensajeFirebase!);
      } else if (e.code == 'unknown') {
        mensajeFirebase = 'Ingrese un correo electronico.';
        fluttertoast(mensajeFirebase!);
      } else if (e.code == 'too-many-requests') {
        mensajeFirebase =
            'Fueron demasiadas peticiones, por favor vuelva intentarlo en 10 minutos.';
        fluttertoast(mensajeFirebase!);
      } else {
        mensajeFirebase = 'Por favor contactar al administrador del App.';
        fluttertoast(mensajeFirebase!);
      }
    } catch (e) {
      mensajeFirebase = '$e';
      fluttertoast(mensajeFirebase!);
    }
  }

  void fluttertoast(String mensaje) {
    Fluttertoast.showToast(
      gravity: ToastGravity.CENTER,
      msg: mensaje,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: MyColors.cAzulLogin,
      textColor: MyColors.cPri5,
      timeInSecForIosWeb: 3,
    );
  }

  void crearUsuario() {
    Future(() {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) {
            return FadeTransition(
              opacity: animation1,
              child: const RegisterEmailPassPage(),
            );
          },
        ),
      );
    });
  }

  void displayDialogAndroid(BuildContext context) {
    showAdaptiveDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Mensaje'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(15)),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                    'Se envio un correo para que pueda restablecer su contraseña, por favor verificar en su bandeja de entrada, correo no deseado o spam.'),
                SizedBox(height: 30),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Ok', style: TextStyle(fontSize: 18)),
              ),
            ],
          );
        });
  }

  void reDisplayDialogAndroid(BuildContext context) {
    showAdaptiveDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Recuperar mi clave'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(15)),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Ingresa tu correo'),
                const SizedBox(height: 15),
                TextFormField(
                  enabled: true,
                  style: TextStyle(color: MyColors.cAzulLogin),
                  controller: reCorreoController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'correo',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(5),
                    hintStyle: TextStyle(color: MyColors.cAzulLogin),
                    prefixIcon: Icon(
                      Icons.email,
                      color: MyColors.cAzulLogin,
                    ),
                  ),
                )
              ],
            ),
            actions: [
              TextButton(
                onPressed: recuperarEmail,
                child: const Text('Restablecer contraseña',
                    style: TextStyle(fontSize: 18)),
              ),
            ],
          );
        });
  }
}
