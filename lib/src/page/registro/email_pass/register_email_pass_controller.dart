import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/response_api.dart';
import '../../../models/user.dart';
import '../../../provider/user.dart';
import '../../../utils/get_it.dart';
import '../../../utils/my_colors.dart';
import '../../../utils/my_snackbar.dart';

class RegisterEmailPassController {
  late BuildContext context;

  TextEditingController correoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final getItUser = getIt<UsersProvider>();

  String uid = '';
  String? mensajeFirebase;

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future init(BuildContext context) async {
    try {
      this.context = context;

      uid = '';

      getItUser.init(context);
    } catch (e) {
      print('Error RegisterEmailPassController: $e');
    }
  }

  void addEmail() async {
    try {
      if (!correoController.text.contains('@')) {
        MySnackbar.show(
          context,
          text: 'Debe ingresar un correo valido.',
          fondo: MyColors.cPri4,
          colorText: MyColors.cAzulLogin,
        );

        return;
      }
      isLoading.value = true;
      String valCorreo =
          await getItUser.getBuscarCorreo(correoController.text); //correo
      if (valCorreo == '1') {
        // ignore: use_build_context_synchronously
        MySnackbar.show(
          context,
          text:
              'El correo ${correoController.text} ya se encuentra registrado.',
          fondo: MyColors.cPri4,
          colorText: MyColors.cAzulLogin,
        );
        isLoading.value = false;
        return;
      }

      if (nameController.text.isEmpty ||
          lastnameController.text.isEmpty ||
          correoController.text.isEmpty ||
          passwordController.text.isEmpty) {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        MySnackbar.show(
          context,
          text: 'Debes ingresar todos los campos',
          fondo: MyColors.cPri4,
          colorText: MyColors.cAzulLogin,
        );

        return;
      }

      // if (vCumpleanio == null || vCumpleanio!.contains('null')) {
      //   MySnackbar.show(context, 'Ingrese su fecha de cumpleaños');
      //   return;
      // }
      if (passwordController.text.length < 6) {
        isLoading.value = false;
        // ignore: use_build_context_synchronously
        MySnackbar.show(
          context,
          text: 'Las contraseñas debe ser mayor a 6 digitos',
          fondo: MyColors.cPri5,
          colorText: MyColors.cAzulLogin,
        );

        return;
      }

      final credencial =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: correoController.text,
        password: passwordController.text,
      );
      uid = credencial.user!.uid.toString();

      // mandar a un page para verificar un correo
      // ignore: use_build_context_synchronously
      context.read<UsersProvider>().uidEmailPass(uid: uid);

      Users usuario = Users(
        name: nameController.text,
        lastname: lastnameController.text,
        phone: '999999999',
        password: uid,
        cumpleanio: '14/1/1988',
        correo: correoController.text,
      );

      ResponseApi? responseApi =
          await getItUser.createUser(usuario, 'Email-Password');
      Fluttertoast.showToast(msg: responseApi.message.toString());
      isLoading.value = false;
      Future(() {
        Navigator.pushNamedAndRemoveUntil(
          context,
          'home',
          (route) => false,
          arguments: usuario.correo,
        );
      });
    } on FirebaseAuthException catch (e) {
      uid = '';
      if (e.code == 'weak-password') {
        mensajeFirebase =
            'La contraseña debe contener al menos una mayúscula y número.';
        fluttertoast(mensajeFirebase!);
      } else if (e.code == 'email-already-in-use') {
        mensajeFirebase =
            'El correo ya se encuentra registrado para otro usuario.';
        fluttertoast(mensajeFirebase!);
      } else if (e.code == 'invalid-email') {
        mensajeFirebase = 'El correo ingresado no es valido.';
        fluttertoast(mensajeFirebase!);
      } else if (e.code == 'unknown') {
        mensajeFirebase = 'Ingrese un correo electronico.';
        fluttertoast(mensajeFirebase!);
      } else {
        mensajeFirebase = 'Por favor contactar al administrador del App.';
        fluttertoast(mensajeFirebase!);
      }
      isLoading.value = false;
      return;
    } catch (e) {
      uid = '';
      print(e);
      mensajeFirebase = '$e';
      fluttertoast(mensajeFirebase!);
      isLoading.value = false;
      return;
    }
  }

  void fluttertoast(String mensaje) {
    Fluttertoast.showToast(
      gravity: ToastGravity.TOP_RIGHT,
      msg: mensaje,
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: MyColors.cPri1,
      textColor: MyColors.cPri5,
      timeInSecForIosWeb: 5,
    );
  }
}
