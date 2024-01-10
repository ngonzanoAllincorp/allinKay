import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../utils/my_colors.dart';
import 'register_email_pass_controller.dart';

class RegisterEmailPassPage extends StatefulWidget {
  const RegisterEmailPassPage({super.key});

  @override
  State<RegisterEmailPassPage> createState() => _RegisterEmailPassPageState();
}

class _RegisterEmailPassPageState extends State<RegisterEmailPassPage> {
  final RegisterEmailPassController _con = RegisterEmailPassController();
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
    return Scaffold(
      appBar: _appBar(),
      body: _body(size),
      bottomNavigationBar: _buttonRegister(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text(
        'REGISTRARSE',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: MyColors.cAzulLogin,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'medium'),
      ),
      centerTitle: true,
      backgroundColor: MyColors.cPri5,
      foregroundColor: MyColors.cAzulLogin,
    );
  }

  SingleChildScrollView _body(Size size) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          Center(
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
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 40, bottom: 20),
            child: Text(
              'Crea un usuario con email y contraseña',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.cAzulLogin,
                  fontSize: 17,
                  fontFamily: 'medium'),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          _textFieldName(size),
          const SizedBox(height: 10),
          _textFieldLastName(size),
          const SizedBox(height: 10),
          _textFieldCorreo(),
          const SizedBox(height: 10),
          _textPassword(),
        ],
      ),
    );
  }

  Widget _textFieldName(Size size) {
    return Container(
      alignment: Alignment.centerLeft,
      width: size.width * 0.5,
      margin: const EdgeInsets.only(left: 20, top: 5, right: 20),
      decoration: BoxDecoration(
          color: MyColors.cPri3, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        style: TextStyle(color: MyColors.cAzulLogin),
        controller: _con.nameController,
        decoration: InputDecoration(
            hintText: 'Nombres',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.cAzulLogin.withOpacity(0.3)),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.cAzulLogin,
            )),
      ),
    );
  }

  Widget _textFieldLastName(Size size) {
    return Container(
      alignment: Alignment.centerLeft,
      width: size.width * 0.7,
      margin: const EdgeInsets.only(left: 20, top: 5, right: 20),
      decoration: BoxDecoration(
          color: MyColors.cAzulLogin, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        style: TextStyle(color: MyColors.cAzulLogin),
        controller: _con.lastnameController,
        decoration: InputDecoration(
            hintText: 'Apellidos',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.cAzulLogin.withOpacity(0.3)),
            prefixIcon: Icon(
              Icons.person,
              color: MyColors.cAzulLogin,
            )),
      ),
    );
  }

  Widget _textFieldCorreo() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 5, right: 20),
      decoration: BoxDecoration(
          color: MyColors.cAzulLogin, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: MyColors.cAzulLogin),
        controller: _con.correoController,
        decoration: InputDecoration(
            hintText: 'Email',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.cAzulLogin.withOpacity(0.3)),
            prefixIcon: Icon(
              Icons.email_rounded,
              color: MyColors.cAzulLogin,
            )),
      ),
    );
  }

  Widget _textPassword() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 20, top: 5, right: 20),
      decoration: BoxDecoration(
          color: MyColors.cAzulLogin, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        // obscureText: true,
        style: TextStyle(color: MyColors.cAzulLogin),
        controller: _con.passwordController,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(15),
            hintStyle: TextStyle(color: MyColors.cAzulLogin.withOpacity(0.3)),
            prefixIcon: Icon(
              Icons.password,
              color: MyColors.cAzulLogin,
            )),
      ),
    );
  }

  Widget _buttonRegister() {
    return ValueListenableBuilder(
      valueListenable: _con.isLoading,
      builder: (BuildContext context, bool value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            // width: double.infinity,
            child: value == false
                ? MaterialButton(
                    minWidth: 200.0,
                    height: 55.0,
                    onPressed: _con.addEmail,
                    color: MyColors.cAzulLogin,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.supervised_user_circle_rounded,
                          color: MyColors.cPri5,
                          size: 40,
                        ),
                        const SizedBox(width: 20),
                        Text(
                          'Registrarse',
                          style: TextStyle(color: MyColors.cPri5, fontSize: 19),
                        ),
                      ],
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: MyColors.cAzulLogin,
                          color: MyColors.cPri3,
                        ),
                        const SizedBox(width: 20),
                        const Text('Creando usuario...')
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
