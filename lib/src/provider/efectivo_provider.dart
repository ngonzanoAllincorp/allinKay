import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../api/environment.dart';
import '../models/user.dart';
import '../utils/shared_pref.dart';

class EfectivoiProvider {
  SharedPref _sharedPref = SharedPref();
  final String _url = Environment.apiAllinKay;

  BuildContext? context;
  Users? user;

  Future init(BuildContext context, Users user) async {
    this.context = context;
    this.user = user;
  }

  //crear orden
  Future<Response> crearPagoConIzipay(
      {required Map orden, required Users users}) async {
    try {
      user = Users.fromJson(
          await _sharedPref.read('user', 'crearPagoContraEntrtega'));
      final url =
          Uri.http(_url, '/api/payments/pagoContraEntrtega/${users.correo}');

      //manda al bakend
      Map<String, dynamic> body = {
        'orden': orden,
      };
      String bodyParams = json.encode(body);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user!.sessionToken!
      };

      final res = await http.post(url, headers: headers, body: bodyParams);
      // final data = json.decode(res.body);

      if (res.statusCode == 401) {
        SharedPref().logout(context!, user!.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }
      return res;
    } catch (e) {
      print('Error crearPagoContraEntrtega: $e');
      Navigator.pop(context!);
      return Response('body', 0);
    }
  }

//fin crear orden
}
