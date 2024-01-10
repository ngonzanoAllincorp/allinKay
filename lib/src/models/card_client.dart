// To parse this JSON data, do
//
//     final cardClient = cardClientFromJson(jsonString);

import 'dart:convert';

List<CardClient> cardClientFromJson(String str) =>
    List<CardClient>.from(json.decode(str).map((x) => CardClient.fromJson(x)));

String cardClientToJson(List<CardClient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CardClient {
  String? id;
  String? idClient;
  String? expirationYear;
  String? expirationMonth;
  String? cardNumber;
  String? documentType;
  String? documentNumber;
  String? nombre;
  bool? estado;
  String? cardBrand; //
  String? cardType; //
  List<CardClient> toList = [];

  CardClient({
    this.id,
    this.idClient,
    this.expirationYear,
    this.expirationMonth,
    this.cardNumber,
    this.documentType,
    this.documentNumber,
    this.nombre,
    this.estado,
    this.cardBrand,
    this.cardType,
  });

  factory CardClient.fromJson(Map<String, dynamic> json) => CardClient(
        id: json["id"],
        idClient: json["id_client"],
        expirationYear: json["expiration_year"],
        expirationMonth: json["expiration_month"],
        cardNumber: json["card_number"],
        documentType: json["document_type"],
        documentNumber: json["document_number"],
        nombre: json["nombre"],
        estado: json["estado"],
        cardBrand: json['card_brand'],
        cardType: json['card_type'],
      );
  CardClient.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    if (jsonList.isEmpty) return;
    for (var item in jsonList) {
      CardClient tienda = CardClient.fromJson(item);
      toList.add(tienda);
    }
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "expiration_year": expirationYear,
        "expiration_month": expirationMonth,
        "card_number": cardNumber,
        "document_type": documentType,
        "document_number": documentNumber,
        "nombre": nombre,
        "estado": estado,
        'card_brand': cardBrand,
        'card_type': cardType,
      };
}
