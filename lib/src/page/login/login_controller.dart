import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../models/response_api.dart';
import '../../models/user.dart';
import '../../provider/user.dart';
import '../../utils/get_it.dart';
import '../../utils/my_colors.dart';
import '../../utils/my_snackbar.dart';

class LoginController {
  late BuildContext context;
  final getItProduct = getIt<UsersProvider>();

  final ValueNotifier<bool> isCheck18 = ValueNotifier(false);
  final ValueNotifier<bool> isCheckTC = ValueNotifier(false);
  final ValueNotifier<bool> isCheckPP = ValueNotifier(false);

  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future init(BuildContext context) async {
    try {
      this.context = context;
    } catch (e) {
      print('Error InicioController: $e');
    }
  }

  bool isValido = false;
  void validaciones() {
    if (isCheck18.value == false || isCheckPP.value == false) {
      //||isCheckTC.value == false
      isValido = false;
    } else {
      isValido = true;
    }
  }

  void loginGoogle() async {
    try {
      validaciones();
      if (isValido == false) {
        MySnackbar.show(
          context,
          fondo: MyColors.cPri5,
          colorText: MyColors.cAzulLogin,
          text: 'Para continuar seleccione todos los casilleros.',
        );
        return;
      }
      isLoading.value = true;
      final googleUserx =
          await GoogleSignIn(scopes: <String>['email']).signIn();

      if (googleUserx == null) {
        isLoading.value = false;
        return;
      }

      final GoogleSignInAccount googleUser = googleUserx;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final dato = result.user;

      String valCorreo = await getItProduct.getBuscarCorreo(dato!.email!);

      // ignore: use_build_context_synchronously
      context.read<UsersProvider>().uidGoogle(uid: dato.uid);

      Users usuario = Users(
        name: dato.displayName,
        lastname: ' ',
        phone: '999999999',
        password: dato.uid,
        cumpleanio: '14/1/1988',
        correo: dato.email,
        image: dato.photoURL,
      );

      if (valCorreo == '1') {
        ///
      } else if (valCorreo == '0') {
        ResponseApi? responseApi =
            await getItProduct.createUser(usuario, 'Google');
        MySnackbar.show(
          context,
          fondo: MyColors.cPri5,
          colorText: MyColors.cAzulLogin,
          text: responseApi.message.toString(),
        );
      }
      isLoading.value = false;
      Future(() {
        Navigator.pushNamedAndRemoveUntil(
          context,
          'home',
          (route) => false,
          arguments: usuario.correo,
        );
      });
    } catch (e) {
      isLoading.value = false;
      if (GoogleSignIn.kSignInCanceledError.isNotEmpty) {
        // ignore: use_build_context_synchronously
        MySnackbar.show(
          context,
          text: 'Cancelo el inicio de session con Google...',
          fondo: MyColors.cPri5,
          colorText: MyColors.cAzulLogin,
        );
      }
    } finally {}
  }

  void loginEmailPass() {
    validaciones();
    if (isValido == false) {
      MySnackbar.show(
        context,
        fondo: MyColors.cPri5,
        colorText: MyColors.cAzulLogin,
        text: 'Para continuar seleccione todos los casilleros.',
      );
      return;
    }
    Navigator.pushNamed(context, 'RegisterEmailPassPage');
  }
}
