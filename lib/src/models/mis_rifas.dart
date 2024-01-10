// To parse this JSON data, do
//
//     final misRifas = misRifasFromJson(jsonString);

import 'dart:convert';

MisRifas misRifasFromJson(String str) => MisRifas.fromJson(json.decode(str));

String misRifasToJson(MisRifas data) => json.encode(data.toJson());

class MisRifas {
  String? idRifas;
  String? idUser;
  List<MisRifa>? misRifas;

  MisRifas({
    this.idRifas,
    this.idUser,
    this.misRifas,
  });

  factory MisRifas.fromJson(Map<String, dynamic> json) => MisRifas(
        idRifas: json["id_rifas"],
        idUser: json["id_user"],
        misRifas: json["mis_rifas"] == null
            ? []
            : List<MisRifa>.from(
                json["mis_rifas"]!.map((x) => MisRifa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_rifas": idRifas,
        "id_user": idUser,
        "mis_rifas": misRifas == null
            ? []
            : List<dynamic>.from(misRifas!.map((x) => x.toJson())),
      };
}

class MisRifa {
  String? numTicket;
  DateTime? createAt;
  int? medioPago;

  MisRifa({
    this.numTicket,
    this.createAt,
    this.medioPago,
  });

  factory MisRifa.fromJson(Map<String, dynamic> json) => MisRifa(
        numTicket: json["num_ticket"],
        createAt: json["create_at"] == null
            ? null
            : DateTime.parse(json["create_at"]),
        medioPago: json["medio_pago"],
      );

  Map<String, dynamic> toJson() => {
        "num_ticket": numTicket,
        "create_at": createAt?.toIso8601String(),
        "medio_pago": medioPago,
      };
}
