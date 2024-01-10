import 'package:allincorp/src/page/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../utils/my_colors.dart';
import '../../widgets/loading_custom_painter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _con = LoginController();
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
      valueListenable: _con.isLoading,
      builder: (BuildContext context, value, Widget? child) {
        return Stack(
          children: [
            Scaffold(
              // body: _body(size),
              body: Stack(
                children: [
                  CustomPaint(
                    painter: CurvaCustomPainter(),
                    child: Container(),
                  ),
                  CustomPaint(
                    painter: CurvaCustomPainter2(),
                    child: Container(),
                  ),
                  _body(size),
                ],
              ),
              bottomNavigationBar: _bottomNavigationBar(context),
            ),
            value
                ? Loading(
                    color: MyColors.cPri5,
                  )
                : const SizedBox()
          ],
        );
      },
    );
  }

  Container _bottomNavigationBar(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.07,
      color: MyColors.cAzulLogin,
      child: Center(
        child: Column(
          children: [
            Text('una app de',
                style: TextStyle(
                  fontSize: 12,
                  color: MyColors.cPri5,
                  // fontFamily: 'Poppins',
                )),
            Text(
              'FUTURA',
              style: TextStyle(
                fontSize: 15,
                color: MyColors.cPri5,
                letterSpacing: 2,
                fontFamily: 'antaris_cf',
              ),
            ),
            Text('ANALITICA AVANZADA',
                style: TextStyle(
                  fontSize: 11,
                  color: MyColors.cPri5,
                  fontFamily: 'adlinnaka',
                )),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView _body(Size size) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).size.height * 0.07,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              SizedBox(
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: MyColors.cPri3,
                    ),
                    Hero(
                      tag: 'login_icon',
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: MyColors.cPri1,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            'assets/img/login_icon.png',
                            width: 100,
                            height: 100,
                            // color: MyColors.cPri1,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 60,
                      bottom: 0,
                      child: Image.asset(
                        'assets/img/hexa1.png',
                        width: 20,
                        height: 20,
                        // color: MyColors.cPri1,
                      ),
                    ),
                    Positioned(
                      left: 30,
                      top: 0,
                      child: Image.asset(
                        'assets/img/hexa3.png',
                        width: 40,
                        height: 40,
                        // color: MyColors.cPri1,
                      ),
                    ),
                    Positioned(
                      right: 40,
                      bottom: 30,
                      child: Image.asset(
                        'assets/img/hexa2.png',
                        width: 30,
                        height: 30,
                        // color: MyColors.cPri1,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Bienvenido',
                style: TextStyle(fontSize: 35, fontFamily: 'bold'),
              ),
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.01),
                child: Text(
                  'Conecta directamente con agentes o propietarios, amplia oportunidades y cierra operaciones inmobiliarias con eficiencia y rapidez.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontFamily: 'medium'),
                ),
              ),

              const Spacer(),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.05, bottom: size.height * 0.02),
                child: Text(
                  'Crea una cuenta gratuita',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: MyColors.cPri5,
                      fontFamily: 'medium'),
                ),
              ),
              InkWell(
                onTap: _con.loginGoogle,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1)),
                  alignment: Alignment.centerLeft,
                  width: size.width * 0.6,
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/img/google.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 10),
                        const Text('Iniciar con Google'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: _con.loginEmailPass,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(width: 1)),
                  alignment: Alignment.center,
                  width: size.width * 0.6,
                  height: 45,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/img/email.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 10),
                        const Text('Email y Contraseña'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Platform.isIOS
              //     ?
              SizedBox(
                width: size.width * 0.6,
                height: 44,
                child: SignInWithAppleButton(
                    text: 'Iniciar con Apple',
                    style: SignInWithAppleButtonStyle.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    iconAlignment: IconAlignment.left,
                    onPressed: () {} //_con.signInWithApple,
                    ),
              )
              // : SizedBox()
              ,
              // SizedBox(height: size.height * 0.02),
              // ValueListenableBuilder(
              //   valueListenable: _con.isCheckTC,
              //   builder: (BuildContext context, bool value, Widget? child) {
              //     return Row(
              //       children: [
              //         Theme(
              //           data: Theme.of(context).copyWith(
              //             unselectedWidgetColor: MyColors.cPri1,
              //           ),
              //           child: Checkbox(
              //             activeColor: MyColors.cPri3,
              //             checkColor: MyColors.cPri4,
              //             value: _con.isCheckTC.value,
              //             onChanged: (value) {
              //               _con.isCheckTC.value = !_con.isCheckTC.value;
              //             },
              //           ),
              //         ),
              //         GestureDetector(
              //           // onTap: _con.pp,
              //           child: Text(
              //             'Acepto los términos y condiciones',
              //             style: TextStyle(
              //               color: MyColors.cPri3,
              //               fontSize: 15,
              //             ),
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // ),
              const SizedBox(height: 20),
              SizedBox(
                height: 20,
                child: ValueListenableBuilder(
                  valueListenable: _con.isCheckPP,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: MyColors.cPri5,
                          ),
                          child: Checkbox(
                            activeColor: MyColors.cPri4,
                            checkColor: MyColors.cAzulLogin,
                            value: _con.isCheckPP.value,
                            onChanged: (value) {
                              _con.isCheckPP.value = !_con.isCheckPP.value;
                            },
                          ),
                        ),
                        GestureDetector(
                          // onTap: _con.pp,
                          child: Text(
                            'Acepto la politica de privacidad',
                            style: TextStyle(
                              color: value ? MyColors.cPri4 : MyColors.cPri5,
                              fontFamily: 'medium',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
                child: ValueListenableBuilder(
                  valueListenable: _con.isCheck18,
                  builder: (BuildContext context, bool value, Widget? child) {
                    return Row(
                      children: [
                        Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: MyColors.cPri5,
                          ),
                          child: Checkbox(
                            activeColor: MyColors.cPri4,
                            checkColor: MyColors.cAzulLogin,
                            value: _con.isCheck18.value,
                            onChanged: (value) {
                              _con.isCheck18.value = !_con.isCheck18.value;
                            },
                          ),
                        ),
                        GestureDetector(
                          // onTap: _con.pp,
                          child: Text(
                            'Soy mayor de 18 años.',
                            style: TextStyle(
                              color: value ? MyColors.cPri4 : MyColors.cPri5,
                              fontFamily: 'medium',
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class CurvaCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill
      ..color = MyColors.cPri3;

    Path path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height * 0.5 - 15)
      ..quadraticBezierTo(
        size.width * 0.6, //la parte mas alta de la curva en el eje X
        size.height * 0.45 - 15, //el tamaño de la curva segun el eje Y
        size.width, //donde termina en X
        size.height * 0.8 - 25, //donde termina en Y
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(0.0, 0.0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}

class CurvaCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill
      ..color = MyColors.cAzulLogin;

    Path path = Path()
      ..moveTo(0.0, 0.0)
      ..lineTo(0.0, size.height * 0.5)
      ..quadraticBezierTo(
        size.width * 0.6, //la parte mas alta de la curva en el eje X
        size.height * 0.45, //el tamaño de la curva segun el eje Y
        size.width, //donde termina en X
        size.height * 0.8, //donde termina en Y
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..lineTo(0.0, 0.0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
