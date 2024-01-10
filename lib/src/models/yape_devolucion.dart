// To parse this JSON data, do
//
//     final yapeToken = yapeTokenFromJson(jsonString);

import 'dart:convert';

List<YapeDevolucion> yapeTokenFromJson(String str) => List<YapeDevolucion>.from(
    json.decode(str).map((x) => YapeDevolucion.fromJson(x)));

String yapeTokenToJson(List<YapeDevolucion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YapeDevolucion {
  String? object;
  String? id;
  String? chargeId;
  int? creationDate;
  int? amount;
  String? reason;
  Metadata? metadata;
  String? status;
  int? lastModified;

  YapeDevolucion({
    this.object,
    this.id,
    this.chargeId,
    this.creationDate,
    this.amount,
    this.reason,
    this.metadata,
    this.status,
    this.lastModified,
  });

  factory YapeDevolucion.fromJson(Map<String, dynamic> json) => YapeDevolucion(
        object: json["object"] == null ? "" : json["object"],
        id: json["id"] == null ? "" : json['id'],
        chargeId: json["charge_id"] == null ? "" : json['charge_id'],
        creationDate: json["creation_date"] == null
            ? 0
            : json["creation_date"] is String
                ? int.parse(json["creation_date"])
                : json["creation_date"],
        amount: json["creation_date"] == null
            ? 0
            : json["amount"] is String
                ? int.parse(json["amount"])
                : json["amount"],
        reason: json["reason"] == null ? "" : json["reason"],
        metadata: Metadata.fromJson(
            json["metadata"] == null ? {'': ''} : json['metadata']),
        status: json["status"] == null ? "" : json["status"],
        lastModified: json["last_modified"] == null
            ? 0
            : json["last_modified"] is String
                ? int.parse(json["last_modified"])
                : json["last_modified"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "id": id,
        "charge_id": chargeId,
        "creation_date": creationDate,
        "amount": amount,
        "reason": reason,
        "metadata": metadata?.toJson(),
        "status": status,
        "last_modified": lastModified,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
