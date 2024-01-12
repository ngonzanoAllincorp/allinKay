import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../api/environment.dart';
import '../models/culqi_cargo_rpt.dart';
import '../models/culqi_token.dart';
import '../models/culqi_token_rpt.dart';
import '../models/user.dart';
import '../models/yape_devolucion.dart';
import '../utils/shared_pref.dart';

class CulqiProvider {
  final String _url = Environment.apiAllinKay;
  final String _api = '/api/culqi';
  late BuildContext context;

  Users? user;

  Future init(BuildContext context) async {
    this.context = context;
  }

  Future<CulqiTokenRpt> createToken(
      CulqiToken culqiToken, String codigo, String idUser, Users users) async {
    try {
      Map yapetoken = {
        'card_number': culqiToken.cardNumber,
        'cvv': culqiToken.cvv,
        'expiration_month': culqiToken.expirationMonth,
        'expiration_year': culqiToken.expirationYear,
        'email': culqiToken.email,
        // 'metadata': {
        //   'dni': culqiToken.metadata?.dni,
        //   'celular': culqiToken.metadata?.celular,
        //   'order_id': culqiToken.metadata?.orderId,
        // }
      };
      Uri url = Uri.http(_url, '$_api/createtoken/$codigo/$idUser');
      String bodyParams = json.encode(yapetoken);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': users.sessionToken!
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        SharedPref().logout(context, users.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }

      final data = json.decode(res.body);
      CulqiTokenRpt responseApi = CulqiTokenRpt.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error createToken: $e');
      return CulqiTokenRpt.fromJson({});
    }
  }

  Future<CulqiCargoRpt> createCargo(CulqiTokenRpt culqiTokenRpt, String codigo,
      String idUser, int amount, String cuota, Users users) async {
    try {
      Map culqicargo = {};
      if (cuota == '0') {
        culqicargo = {
          'amount': amount,
          'currency_code': 'PEN',
          'email': culqiTokenRpt.email, //culqiTokenRpt.email,
          'source_id': culqiTokenRpt.id,
          'installments': '0'
        };
      } else {
        culqicargo = {
          'amount': amount,
          'currency_code': 'PEN',
          'email': culqiTokenRpt.email,
          'source_id': culqiTokenRpt.id,
          'installments': cuota
        };
      }
      Uri url = Uri.http(_url, '$_api/createop/$codigo/$idUser');
      String bodyParams = json.encode(culqicargo);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': users.sessionToken!
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        SharedPref().logout(context, users.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }

      final data = json.decode(res.body);
      CulqiCargoRpt responseApi = CulqiCargoRpt.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error createCargo: $e');
      return CulqiCargoRpt.fromJson({});
    }
  }

  //crear orden
  Future<Response?> crearOrdenConCulqi({
    required Map orden,
    required String sessionToken,
  }) async {
    try {
      final url = Uri.http(_url, '/api/culqi/crearordenconculqi');

      //manda al bakend
      Map<String, dynamic> body = {'orden': orden};

      // //print(''PARAMS: $body');

      String bodyParams = json.encode(body);
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
      return res;
    } catch (e) {
      print('Error crearOrdenConCulqi: $e');
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
    Users? users,
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
        'Authorization': users!.sessionToken!
      };
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        SharedPref().logout(context, users.id!);
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
}
