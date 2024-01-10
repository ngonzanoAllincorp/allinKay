// To parse this JSON data, do
//
//     final soat = soatFromJson(jsonString);

import 'dart:convert';

List<Soat> soatFromJson(String str) =>
    List<Soat>.from(json.decode(str).map((x) => Soat.fromJson(x)));

String soatToJson(List<Soat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Soat {
  String? id;
  String? idUser;
  String? nameEmpresa;
  String? detalles;
  String? contacto;
  String? image;
  DateTime? createAt;
  String? linkwhatsapp;
  List<Soat> toList = [];

  Soat({
    this.id,
    this.idUser,
    this.nameEmpresa,
    this.detalles,
    this.contacto,
    this.image,
    this.createAt,
    this.linkwhatsapp,
  });

  factory Soat.fromJson(Map<String, dynamic> json) => Soat(
        id: json["id"],
        idUser: json["id_user"],
        nameEmpresa: json["name_empresa"],
        detalles: json["detalles"],
        contacto: json["contacto"],
        image: json["image"],
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        linkwhatsapp: json["linkwhatsapp"],
      );
  Soat.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    if (jsonList.isEmpty) return;
    for (var item in jsonList) {
      Soat soat = Soat.fromJson(item);
      toList.add(soat);
    }
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "name_empresa": nameEmpresa,
        "detalles": detalles,
        "contacto": contacto,
        "image": image,
        "create_at": createAt?.toIso8601String(),
        "linkwhatsapp": linkwhatsapp,
      };
}
