import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../constantes/constante.dart';
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
    Navigator.pushNamed(context, 'EmailPassPage');
  }

  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  void signInWithApple() async {
    try {
      validaciones();
      if (isValido == false) {
        MySnackbar.show(
          context,
          fondo: MyColors.cPri5,
          colorText: MyColors.cAzulLogin,
          text: 'Para continuar seleccione todos los casilleros.',
        );
        return null;
      }
      isLoading.value = true;
      String clientID = 'com.ngonzano.loginallinkay';

      // String redirectURL =
      //     'https://dull-mirage-opal.glitch.me/callbacks/sign_in_with_apple';

      String redirectURL =
          'https://lightning-ten-chevre.glitch.me/callbacks/sign_in_with_apple';

      final rawNonce = generateNonce();

      final nonce = sha256ofString(rawNonce);

      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: Platform.isIOS ? nonce : null,
        webAuthenticationOptions: Platform.isIOS
            ? null
            : WebAuthenticationOptions(
                clientId: clientID,
                redirectUri: Uri.parse(redirectURL),
              ),
      );

      final AuthCredential appleAuthCredential =
          OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        rawNonce: Platform.isIOS ? rawNonce : null,
        accessToken: Platform.isIOS ? null : appleCredential.authorizationCode,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(appleAuthCredential);

      final userx = userCredential.user!;
      // print(userCredential.user!.displayName);
      // print(userCredential.user!.photoURL);
      // print(userCredential.user!.phoneNumber);
      // print(userCredential.user!.email);
      // print(userCredential.user!.uid);
      String valCorreo = await getItProduct.getBuscarCorreo(userx.email!);

      // ignore: use_build_context_synchronously
      context.read<UsersProvider>().uidApple(uid: userx.uid);

      Users usuario = Users(
        name: userx.displayName == null ? userx.email : userx.displayName,
        lastname: ' ',
        phone: userx.phoneNumber == null ? 'phone' : userx.phoneNumber,
        password: userx.uid,
        cumpleanio: '14/1/1988',
        correo: userx.email,
        image: userx.photoURL == null ? Constante.imgDefect : userx.photoURL,
      );

      if (valCorreo == '1') {
        ///
      } else if (valCorreo == '0') {
        ResponseApi? responseApi =
            await getItProduct.createUser(usuario, 'Apple');
        MySnackbar.show(
          context,
          text: responseApi.message.toString(),
          fondo: MyColors.cPri5,
          colorText: MyColors.cAzulLogin,
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
      print('Error signInWithApple: $e');
      isLoading.value = false;
      MySnackbar.show(context,
          text: 'Verificar que su version de IOS sea mayor o igual a 13.');
      // rethrow;
    }
  }
}
