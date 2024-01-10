import 'dart:convert';

import 'rol.dart';

Users userFromJson(String str) => Users.fromJson(json.decode(str));

String userToJson(Users data) => json.encode(data.toJson());

class Users {
  String? id;
  String? name;
  String? lastname;
  String? phone;
  String? password;
  String? sessionToken;
  String? notificationToken;
  String? image;
  String? cumpleanio;
  bool? estado;
  List<Rol>? roles = [];
  List<Users> toList = [];
  double? lat;
  double? lng;
  bool? estadoDelivery;
  String? correo;
  String? documento;
  String? rangoClienteTienda;
  String? rangoRepartidorTienda;

  Users({
    this.id,
    this.name,
    this.lastname,
    this.phone,
    this.password,
    this.sessionToken,
    this.notificationToken,
    this.cumpleanio,
    this.estado,
    this.image,
    this.roles,
    this.lat,
    this.lng,
    this.estadoDelivery,
    this.correo,
    this.documento,
    this.rangoClienteTienda,
    this.rangoRepartidorTienda,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json["id"] is int ? json['id'].toString() : json["id"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        password: json["password"],
        sessionToken: json["session_token"],
        notificationToken: json["notification_token"],
        cumpleanio: json["cumpleanio"],
        estado: json["estado"],
        estadoDelivery: json["estado_delivery"],
        image: json["image"],
        roles: json["roles"] == null
            ? []
            : List<Rol>.from(json['roles'].map((model) => Rol.fromJson(model))),
        lat: json['lat'] == null
            ? 0
            : json['lat'] is String
                ? double.parse(json["lat"])
                : isInteger(json["lat"])
                    ? json["lat"].toDouble()
                    : json['lat'],
        lng: json['lng'] == null
            ? 0
            : json['lng'] is String
                ? double.parse(json["lng"])
                : isInteger(json["lng"])
                    ? json["lng"].toDouble()
                    : json['lng'],
        correo: json["correo"],
        documento: json["documento"],
        rangoClienteTienda: json["rango_cliente_tienda"],
        rangoRepartidorTienda: json["rango_repartidor_tienda"],
      );

  Users.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    if (jsonList.isEmpty) return;
    for (var item in jsonList) {
      Users user = Users.fromJson(item);
      toList.add(user);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "password": password,
        "session_token": sessionToken,
        "notification_token": notificationToken,
        "cumpleanio": cumpleanio,
        "estado": estado,
        "estado_delivery": estadoDelivery,
        "image": image,
        "roles": roles,
        "lat": lat,
        "lng": lng,
        'correo': correo,
        'documento': documento,
        "rango_cliente_tienda": rangoClienteTienda,
        "rango_repartidor_tienda": rangoRepartidorTienda
      };
  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();
}
