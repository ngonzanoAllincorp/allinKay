import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fluttertoast/fluttertoast.dart';

import '../api/environment.dart';
import '../models/response_api.dart';
import '../models/user.dart';
import '../utils/shared_pref.dart';

class UsersProvider extends ChangeNotifier {
  final String _url = Environment.apiRifas;
  final String _api = '/api/users';

  BuildContext? context;
  Users? sessionUser;

  // final SharedPref _sharedPref = SharedPref();

  Future init(BuildContext context, {Users? sessionUser}) async {
    context = context;
    sessionUser = sessionUser;
  }

  Future<Map> versionApp() async {
    try {
      Uri url = Uri.http(_url, '$_api/version');

      final res = await http.get(url);

      if (res.statusCode == 401) {
        // NO AUTORIZADO
        Fluttertoast.showToast(
            msg: 'Error al obtener la version.', timeInSecForIosWeb: 3);
      }

      final data = json.decode(res.body);
      Map user = data;
      return user;
    } catch (e) {
      print('Error versionApp: $e');
      return {};
    }
  }

  Future<Map> whatsApp(Users users) async {
    try {
      // //print(''SESION TOKEN: ${sessionUserX.sessionToken}');
      Uri url = Uri.http(_url, '$_api/whatsApp');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': users.sessionToken!,
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        SharedPref().logout(context!, users.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }
      final data = json.decode(res.body); // CATEGORIAS
      //print(''getByCategory - ${data}');
      Map user = data;
      return user;
    } catch (e) {
      print('Error whatsApp: $e');
      return {};
    }
  }

  Future<ResponseApi> logout(String idUser) async {
    try {
      Uri url = Uri.http(_url, '$_api/logout');
      String bodyParams = json.encode({'id': idUser});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error logout: $e');
      return ResponseApi(); //return null!;
    }
  }

  Future<ResponseApi> eliminarCuenta(String idUser) async {
    try {
      Uri url = Uri.http(_url, '$_api/eliminaruser');
      String bodyParams = json.encode({'id': idUser});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error logout: $e');
      return ResponseApi(); //return null!;
    }
  }

  Future<String> getBuscarCorreo(String correo) async {
    try {
      Uri url = Uri.http(_url, '$_api/buscarcorreo/$correo');
      // Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.get(url);

      final data = json.decode(res.body);

      return data['count'].toString();
    } catch (e) {
      print('Error getBuscarCorreo: $e');
      return '0';
    }
  }

  Future<ResponseApi> createUser(Users user, String withLogin) async {
    try {
      Uri url = Uri.http(_url, '$_api/create/$withLogin');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        SharedPref().logout(context!, sessionUser!.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }

      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error crear direccion: $e');
      return ResponseApi.fromJson({});
    }
  }

  Future<ResponseApi> login(String dato, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String? bodyParams = json.encode({'dato': dato, 'password': password});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final res = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error login: $e');
      return ResponseApi(); //antes Null
    }
  }

  Future<ResponseApi> buscarUser(Users users) async {
    try {
      Uri url = Uri.http(_url, '$_api/buscaruser/${users.correo}');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': users.sessionToken!
      };
      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        SharedPref().logout(context!, users.id!);
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }
      final data = json.decode(res.body); // CATEGORIAS
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error buscarUser: $e');
      return ResponseApi.fromJson({});
    }
  }

  Future<ResponseApi> updUser(Users user) async {
    try {
      // User sessionUserX = User.fromJson(await _sharedPref.read('user', 'updateToDispatched'));
      Uri url = Uri.http(_url, '$_api/upduser');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user.sessionToken!
      };
      final res = await http.put(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        SharedPref().logout(context!, '${user.id}');
        Fluttertoast.showToast(
            msg: 'Tu sesion expiro, por favor volver a ingresar.',
            timeInSecForIosWeb: 5);
      }

      final data = json.decode(res.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error en updateToDispatched: $e');
      return ResponseApi();
    }
  }

  Future<Map> constantesApp(String codigo, String iduser, Users users) async {
    try {
      Uri url = Uri.http(_url, '$_api/buscarconst/$codigo/$iduser');

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
      print('Error versionApp provider: $e');
      return {};
    }
  }

  ///

  String _google = '';
  String get google => _google;

  void uidGoogle({required String uid}) {
    _google = uid;
    notifyListeners();
  }

  String _emailPass = '';
  String get emailPass => _emailPass;

  void uidEmailPass({required String uid}) {
    _emailPass = uid;
    notifyListeners();
  }

  String _apple = '';
  String get apple => _apple;

  void uidApple({required String uid}) {
    _apple = uid;
    notifyListeners();
  }

  ///
}
