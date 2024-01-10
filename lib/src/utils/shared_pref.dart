import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/user.dart';

class SharedPref {
  void save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  Future<dynamic> read(String key, String? page) async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.getString(key) == null) {
      if (page == 'login') {
        //print(''read | LoginController()');
        return {'': dynamic};
      } else if (page == 'init_client_orders_create') {
        //print(''read | ClientOrdersCreateController()');
        return [];
      } else if (page == 'isCloseToDeliveryPosition') {
        //print(''read | isCloseToDeliveryPosition');
        return {'': dynamic};
      } else if (page == 'getByStatus') {
        print('read | getByStatus');
        return {'': dynamic};
      } else if (page == 'init_client_address_create') {
        //print(''read | init_client_address_create');
        return {'': dynamic};
      } else if (page == 'init_client_address_list') {
        //print(''read | init_client_address_list');
        return {'': dynamic};
      } else if (page == 'getAddress') {
        //print(''read | getAddress');
        return {'': dynamic};
      } else if (page == 'init_client_orders_detail') {
        //print(''read | init_client_orders_detail');
        return {'': dynamic};
      } else if (page == 'init_client_orders_list') {
        //print(''read | init_client_orders_list');
        return {'': dynamic};
      } else if (page == 'init_client_orders_map') {
        //print(''read | init_client_orders_map');
        return {'': dynamic};
      } else if (page == 'init_client_payments_create') {
        //print(''read | init_client_payments_create');
        return {'': dynamic};
      } else if (page == 'init_client_payments_status') {
        //print(''read | init_client_payments_status');
        return {'': dynamic};
      } else if (page == 'init_client_payments_installments-selectedProducts') {
        //print(''read | init_client_payments_installments-selectedProducts');
        return []; //List<dynamic>;
      } else if (page == 'init_client_payments_installments-user') {
        //print(''read | init_client_payments_installments-user');
        return {'': dynamic};
      } else if (page == 'init_client_payments_installments-address') {
        //print(''read | init_client_payments_installments-address');
        return {'': dynamic};
      } else if (page == 'init_client_products_detail') {
        //print(''read | init_client_products_detail');
        return []; //List<dynamic>;
      } else if (page == 'init_client_products_list') {
        //print(''read | init_client_products_list');
        return {'': dynamic};
      } else if (page == 'init_client_update') {
        //print(''read | init_client_update');
        return {'': dynamic};
      } else if (page == 'init_delivery_orders_detail') {
        //print(''read | init_delivery_orders_detail');
        return {'': dynamic};
      } else if (page == 'init_delivery_orders_list') {
        //print(''read | init_delivery_orders_list');
        return {'': dynamic};
      } else if (page == 'init_delivery_orders_map') {
        //print(''read | init_delivery_orders_list');
        return {'': dynamic};
      } else if (page == 'init_restaurant_categories_create') {
        //print(''read | init_restaurant_categories_create');
        return {'': dynamic};
      } else if (page == 'init_restaurant_orders_detail') {
        //print(''read | init_restaurant_orders_detail');
        return {'': dynamic};
      } else if (page == 'init_restaurant_list') {
        //print(''read | init_restaurant_list');
        return {'': dynamic};
      } else if (page == 'init_restaurant_products_create') {
        //print(''read | init_restaurant_products_create');
        return {'': dynamic};
      } else if (page == 'init_roles') {
        //print(''read | init_roles');
        return {'': dynamic};
      } else if (page == 'getByUser') {
        //print(''read | init_roles');
        return {'': dynamic};
      } else if (page == 'getAdminsNotificationTokens') {
        //print(''read | getAdminsNotificationTokens');
        return {'': dynamic};
      } else if (page == 'getDeliveryMen') {
        //print(''read | getDeliveryMen');
        return {'': dynamic};
      } else if (page == 'getByDeliveryAndStatus') {
        //print(''read | getByDeliveryAndStatus');
        return {'': dynamic};
      } else if (page == 'createPayment') {
        //print(''read | createPayment');
        return {'': dynamic};
      } else if (page == 'getByClientAndStatus') {
        //print(''read | getByClientAndStatus');
        return {'': dynamic};
      } else if (page == 'create') {
        //print(''read | create');
        return {'': dynamic};
      } else if (page == 'updateToDispatched') {
        //print(''read | updateToDispatched');
        return {'': dynamic};
      } else if (page == 'updateToOnTheWay') {
        //print(''read | updateToOnTheWay');
        return {'': dynamic};
      } else if (page == 'updateToDelivered') {
        //print(''read | updateToDelivered');
        return {'': dynamic};
      } else if (page == 'updateLatLng') {
        //print(''read | updateLatLng');
        return {'': dynamic};
      } else if (page == 'getByCategoryAndProductName') {
        //print(''read | getByCategoryAndProductName');
        return {'': dynamic};
      } else if (page == 'create') {
        //print(''read - product | create');
        return {'': dynamic};
      } else if (page == 'countChat') {
        return {
          'count': 0,
          'message': [],
        };
        // return 0;
      } else {
        //print(''read | agregar una condicion en el shared_pref.dart');
        // return null;
        return {'': dynamic};
      }
      //{'': dynamic};
    } //antes era null

    return json.decode(prefs.getString(key)!);
  }

  Future<bool> contains(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(key);
    } catch (e) {
      return false;
    }
  }

  Future<bool> remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(key);
    } catch (e) {
      return false;
    }
  }

  void logout(BuildContext context, String idUser) async {
    try {
      if (idUser != 'null') {
        UsersProvider usersProvider = UsersProvider();
        usersProvider.init(context);
        await usersProvider.logout(idUser);
        await remove('user');

        Future(() {
          Navigator.pushNamedAndRemoveUntil(
              context, 'inicio', (route) => false);
        });
      }
    } catch (e) {
      print('Error logout: $e');
    }
  }

  void eliminarCuenta(BuildContext context, String idUser) async {
    try {
      if (idUser != 'null') {
        UsersProvider usersProvider = UsersProvider();
        usersProvider.init(context);
        await usersProvider.logout(idUser);
        await usersProvider.eliminarCuenta(idUser);
        await remove('user');

        Future(() {
          Navigator.pushNamedAndRemoveUntil(
              context, 'inicio', (route) => false);
        });
      }
    } catch (e) {
      print('Error logout: $e');
    }
  }
}
