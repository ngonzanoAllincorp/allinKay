import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../api/environment.dart';
import '../models/user.dart';
import '../models/yape_cargo.dart';
import '../models/yape_devolucion.dart';
import '../models/yape_token.dart';
import '../utils/shared_pref.dart';

class YapeProvider {
  final String _url = Environment.apiAllinKay;
  final String _api = '/api/yape';
  late BuildContext context;
  Users? sessionUser;
  // final SharedPref _sharedPref = SharedPref();
  Users? user;

  Future init(BuildContext context, Users sessionUser) async {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<YapeToken> createToken(YapeToken yapeToken, String codigo,
      String idUser, String sessionToken) async {
    try {
      Map yapetoken = {
        'otp': yapeToken.otp,
        'number_phone': yapeToken.number_phone,
        'amount': yapeToken.amount
      };
      Uri url = Uri.http(_url, '$_api/createtoken/$codigo/$idUser');
      String bodyParams = json.encode(yapetoken);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionToken
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        // ignore: use_build_context_synchronously
        SharedPref().logout(context, sessionUser!.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }

      final data = json.decode(res.body);
      YapeToken responseApi = YapeToken.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error createToken: $e');
      return YapeToken.fromJson({});
    }
  }

  Future<YapeCargo> createCargo(
      YapeCargo yapeCargo, String codigo, String idUser) async {
    try {
      Map yapecargo = {
        'amount': yapeCargo.amount,
        'currency_code': yapeCargo.currencyCode,
        'email': yapeCargo.email,
        'source_id': yapeCargo.source_id //token
      };
      Uri url = Uri.http(_url, '$_api/createop/$codigo/$idUser');
      String bodyParams = json.encode(yapecargo);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        // ignore: use_build_context_synchronously
        SharedPref().logout(context, sessionUser!.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }

      final data = json.decode(res.body);
      YapeCargo responseApi = YapeCargo.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error createToken: $e');
      return YapeCargo.fromJson({});
    }
  }

  //crear orden
  Future<Response?> crearOrdenConYape({
    required Map orden,
    required String sessionToken,
  }) async {
    try {
      final url = Uri.http(_url, '/api/yape/crearordenconyape');

      //manda al bakend
      Map<String, dynamic> body = {'orden': orden};

      // //print(''PARAMS: $body');

      String bodyParams = json.encode(body);
      // //print(''bodyParams: ${bodyParams}');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionToken
      };

      final res = await http.post(url, headers: headers, body: bodyParams);
      // final data = json.decode(res.body);

      if (res.statusCode == 401) {
        // ignore: use_build_context_synchronously
        SharedPref().logout(context, user!.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }
      //print('res);
      return res;
    } catch (e) {
      print('Error crearOrdenConYape: $e');
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      return null;
    }
  }

  Future<YapeDevolucion> createDevolucion({
    YapeDevolucion? yapeDevolucion,
    String? codigo,
    String? idTienda,
    String? idOrden,
  }) async {
    try {
      Map yapedevolucion = {
        'amount': yapeDevolucion!.amount,
        'charge_id': yapeDevolucion.chargeId,
        'reason': yapeDevolucion.reason,
        'idorder': idOrden
      };
      Uri url = Uri.http(_url, '$_api/createdevolucion/$codigo/$idTienda');
      String bodyParams = json.encode(yapedevolucion);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser!.sessionToken!
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        SharedPref().logout(context, sessionUser!.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }

      final data = json.decode(res.body);
      YapeDevolucion responseApi = YapeDevolucion.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error createDevolucion: $e');
      return YapeDevolucion.fromJson({});
    }
  }

  Future<Map> correlativo(String idRifas, Users users) async {
    try {
      Uri url = Uri.http(_url, '$_api/correlativo/$idRifas');

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': users.sessionToken!
      };

      final res = await http.get(url, headers: headers);
      if (res.statusCode == 401) {
        // NO AUTORIZADO
        Fluttertoast.showToast(
            msg: 'Error al obtener las tiendas.', timeInSecForIosWeb: 3);
      }

      final data = json.decode(res.body);
      Map user = data;
      return user;
    } catch (e) {
      print('Error correlativo provider: $e');
      return {};
    }
  }
}
