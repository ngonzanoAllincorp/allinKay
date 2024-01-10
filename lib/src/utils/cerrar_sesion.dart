import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../provider/user.dart';
import 'my_colors.dart';
import 'shared_pref.dart';

class CerrarSesion extends StatefulWidget {
  const CerrarSesion({super.key});

  @override
  State<CerrarSesion> createState() => _CerrarSesionState();
}

class _CerrarSesionState extends State<CerrarSesion> {
  final SharedPref _sharedPref = SharedPref();
  String? idUser;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      idUser = ModalRoute.of(context)?.settings.arguments as String;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: MyColors.cPri1.withOpacity(0.5),
              ),
              color: MyColors.cPri4.withOpacity(0.1),
            ),
            width: size.width * 0.75,
            height: size.height * 0.4,
            child: Column(
              children: [
                const Center(
                    child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 10.0,
                    left: 40,
                    right: 40,
                    top: 30,
                  ),
                  child: Text(
                    '¿Quiere salir de su cuenta?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'Intel',
                    ),
                  ),
                )),
                const Center(
                    child: Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    left: 30,
                    right: 30,
                    bottom: 20,
                  ),
                )),
                _buttonCerrarSession(context),
                _buttonCancelar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool estadoSession = false;
  Widget _buttonCerrarSession(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 5),
      child: MaterialButton(
        elevation: 0,
        minWidth: 200.0,
        height: 45.0,
        onPressed: () {
          setState(() {
            estadoSession = true;
          });
          context.read<UsersProvider>().uidGoogle(uid: '');
          context.read<UsersProvider>().uidEmailPass(uid: '');
          context.read<UsersProvider>().uidApple(uid: '');
          // context.read<UsersProvider>().uidFacebook(uid: '');
          FirebaseAuth.instance.signOut();
          _sharedPref.logout(context, idUser!);
        },
        color: estadoSession == false ? MyColors.cPri1 : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'Cerrar sesión',
          style: TextStyle(
            color: MyColors.cPri5,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

  Widget _buttonCancelar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 5),
      child: MaterialButton(
        elevation: 0,
        minWidth: 200.0,
        height: 45.0,
        onPressed: () {
          Navigator.pop(context);
        },
        color: MyColors.cPri5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          'Cancelar',
          style: TextStyle(
            color: MyColors.cPri1,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
