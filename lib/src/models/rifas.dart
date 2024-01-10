import 'dart:convert';

List<Rifas> rifasFromJson(String str) =>
    List<Rifas>.from(json.decode(str).map((x) => Rifas.fromJson(x)));

String rifasToJson(List<Rifas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rifas {
  String? id;
  String? descripcion;
  String? detalles;
  String? price;
  String? image;
  DateTime? createAt;
  String? premio1;
  String? premio2;
  String? premio3;
  String? premio4;
  String? premio5;
  DateTime? fechaSorteo;
  String? idUser;
  String? linkwhatsapp;
  String? fecha_fin;
  List<Rifas> toList = [];

  Rifas({
    this.id,
    this.descripcion,
    this.detalles,
    this.price,
    this.image,
    this.createAt,
    this.premio1,
    this.premio2,
    this.premio3,
    this.premio4,
    this.premio5,
    this.fechaSorteo,
    this.idUser,
    this.linkwhatsapp,
    this.fecha_fin,
  });

  factory Rifas.fromJson(Map<String, dynamic> json) => Rifas(
        id: json["id"],
        descripcion: json["descripcion"],
        detalles: json["detalles"],
        price: json["price"],
        image: json["image"],
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        premio1: json["premio1"],
        premio2: json["premio2"],
        premio3: json["premio3"],
        premio4: json["premio4"],
        premio5: json["premio5"],
        fechaSorteo: json["fecha_sorteo"] == null
            ? null
            : DateTime.parse(json["fecha_sorteo"]),
        idUser: json["id_user"],
        linkwhatsapp: json['linkwhatsapp'],
        fecha_fin: json['fecha_fin'],
      );
  Rifas.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    if (jsonList.isEmpty) return;
    for (var item in jsonList) {
      Rifas rifas = Rifas.fromJson(item);
      toList.add(rifas);
    }
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
        "detalles": detalles,
        "price": price,
        "image": image,
        "create_at": createAt?.toIso8601String(),
        "premio1": premio1,
        "premio2": premio2,
        "premio3": premio3,
        "premio4": premio4,
        "premio5": premio5,
        "fecha_sorteo": fechaSorteo?.toIso8601String(),
        "id_user": idUser,
        "linkwhatsapp": linkwhatsapp,
        "fecha_fin": fecha_fin,
      };

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();
}
