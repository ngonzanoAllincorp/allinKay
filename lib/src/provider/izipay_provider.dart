import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../api/environment.dart';
import '../models/user.dart';
import '../utils/shared_pref.dart';

import 'package:http/http.dart' as http;

class IzipayProvider {
  final String _url = Environment.apiAllinKay;
  late BuildContext context;
  Users? sessionUser;
  Users? user;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<String> urlNew({
    double? amount,
    int? items,
    String? correo,
    String? id_user,
    String? nombre,
    String? apellido,
  }) async {
    try {
      Map datos = {
        'amount': amount,
        'currency': 'PEN',
        'items': items,
        'email': correo,
        'id_user': id_user,
        'nombre': nombre,
        'apellido': apellido,
      };
      Uri url = Uri.http(_url, '/api/paymentForm');
      String bodyParams = json.encode(datos);
      Map<String, String> headers = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode != 200) {
        SharedPref().logout(context, sessionUser!.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }
      String responseString = jsonDecode(res.body)["redirect_url"].toString();

      return responseString;
    } catch (e) {
      print('Error urlNew: $e');
      return '';
    }
  }

  Future<dynamic> cancelOrRefund(String id_orden) async {
    try {
      // sessionUser =
      //     User.fromJson(await _sharedPref.read('user', 'getDeliveryMen'));
      Uri url = Uri.http(_url, '/api/cancelOrRefund/$id_orden');
      // Map<String, String> headers = {
      //   'Content-type': 'application/json',
      //   'Authorization': sessionUser!.sessionToken!
      // };
      final res = await http.post(url);

      if (res.statusCode == 401) {
        // NO AUTORIZADO
        SharedPref().logout(context, sessionUser!.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }

      final data = json.decode(res.body);
      return data;
    } catch (e) {
      return 'Error cancelOrRefund $e';
    }
  }

  Future<dynamic> updateTrans(String id_orden, int amount) async {
    try {
      // sessionUser =
      //     User.fromJson(await _sharedPref.read('user', 'getDeliveryMen'));
      Uri url = Uri.http(_url, '/api/updateTrans/$id_orden/$amount');
      // Map<String, String> headers = {
      //   'Content-type': 'application/json',
      //   'Authorization': sessionUser!.sessionToken!
      // };
      final res = await http.post(url);

      if (res.statusCode == 401) {
        // NO AUTORIZADO
        SharedPref().logout(context, sessionUser!.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }

      final data = json.decode(res.body);
      return data;
    } catch (e) {
      return 'Error cancelOrRefund $e';
    }
  }
}
