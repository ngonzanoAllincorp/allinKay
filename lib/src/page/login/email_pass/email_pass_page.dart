import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../utils/my_colors.dart';
import '../../../widgets/widget_animado.dart';
import 'email_pass_contrroller.dart';

class EmailPassPage extends StatefulWidget {
  const EmailPassPage({super.key});

  @override
  State<EmailPassPage> createState() => _EmailPassPageState();
}

class _EmailPassPageState extends State<EmailPassPage> {
  final EmailPassController _con = EmailPassController();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: MyColors.cPri5,
        backgroundColor: MyColors.cAzulLogin,
        title: const Text(
          'Ingresar email y contraseña',
          style: TextStyle(fontSize: 18, fontFamily: 'bold'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(children: [
          Stack(
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
            ],
          ),
          const SizedBox(height: 40),
          _textFieldCorreo(),
          const SizedBox(height: 5),
          _password(),
          const SizedBox(height: 20),
          _buttonLogin(
            _con.correoController.text,
          ),
          const SizedBox(height: 20),
          reClave(),
          const SizedBox(height: 45),
          // const Divider(
          //   thickness: 1,
          //   endIndent: 20,
          //   indent: 20,
          // ),
          crearUsuario(),
        ]),
      ),
    );
  }

  WidgetAnimado reClave() {
    return WidgetAnimado(
      ejeX: -1000,
      duration: const Duration(milliseconds: 1500),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: InkWell(
          onTap: () {
            _con.reDisplayDialogAndroid(context);
          },
          child: Text(
            'Olvide mi clave',
            style: TextStyle(
              color: MyColors.cAzulLogin,
              fontSize: 17,
              fontFamily: 'medium',
            ),
          ),
        ),
      ),
    );
  }

  WidgetAnimado crearUsuario() {
    return WidgetAnimado(
      ejeX: -500,
      duration: const Duration(milliseconds: 1500),
      child: MaterialButton(
        height: 50,
        onPressed: _con.crearUsuario,
        color: MyColors.cPri5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_add,
              color: MyColors.cAzulLogin,
            ),
            const SizedBox(width: 20),
            Text(
              'Crear cuenta nueva',
              style: TextStyle(
                  color: MyColors.cAzulLogin,
                  fontSize: 17,
                  fontFamily: 'medium'),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }

  bool estado = true;
  WidgetAnimado _password() {
    return WidgetAnimado(
      child: TextFormField(
        enabled: true,
        obscureText: estado ? true : false,
        style: TextStyle(color: MyColors.cAzulLogin),
        controller: _con.passwordController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.mark_email_read,
            color: MyColors.cAzulLogin,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              if (this.mounted) {
                setState(() {
                  estado = !estado;
                });
              }
            },
            child: Icon(
              estado ? FontAwesomeIcons.eyeSlash : FontAwesomeIcons.eye,
              color: MyColors.cAzulLogin,
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldCorreo() {
    return WidgetAnimado(
      child: TextFormField(
        enabled: true,
        style: TextStyle(color: MyColors.cAzulLogin),
        controller: _con.correoController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: 'correo',
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(10),
          prefixIcon: Icon(
            Icons.email,
            color: MyColors.cAzulLogin,
          ),
        ),
      ),
    );
  }

  Widget _buttonLogin(String email) {
    return WidgetAnimado(
      ejeX: -150,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: _con.estadoLogin == false
              ? MyColors.cAzulLogin
              : MyColors.cAzulLogin.withOpacity(0.5),
          borderRadius: _con.estadoLogin == false
              ? BorderRadius.circular(10)
              : BorderRadius.circular(20),
        ),
        child: MaterialButton(
          height: 50, minWidth: 200,
          onPressed: _con.loginEmail,
          // color: _con.estadoLogin
          //     ? MyColors.cAzulLogin
          //     : MyColors.cAzulLogin.withBlue(100),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.email_sharp,
                color: _con.estadoLogin == false
                    ? MyColors.cPri5
                    : MyColors.cPri5.withOpacity(0.5),
              ),
              const SizedBox(width: 20),
              Text(
                _con.estadoLogin == false ? 'Iniciar sesión' : 'Iniciando ...',
                style: TextStyle(
                  color: _con.estadoLogin == false
                      ? MyColors.cPri5
                      : MyColors.cPri5.withOpacity(0.5),
                  fontSize: 18,
                  fontFamily: 'medium',
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
    );
  }

  void refresh() {
    // setState(() {});
    if (this.mounted) {
      // check whether the state object is in tree
      setState(() {
        // make changes here
      });
    }
  }
}
