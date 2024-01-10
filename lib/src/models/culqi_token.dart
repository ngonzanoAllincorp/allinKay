import 'dart:convert';

CulqiToken culqiTokenFromJson(String str) =>
    CulqiToken.fromJson(json.decode(str));

String culqiTokenToJson(CulqiToken data) => json.encode(data.toJson());

class CulqiToken {
  String? cardNumber;
  String? cvv;
  String? expirationMonth;
  String? expirationYear;
  String? email;
  Metadata? metadata;

  CulqiToken({
    this.cardNumber,
    this.cvv,
    this.expirationMonth,
    this.expirationYear,
    this.email,
    this.metadata,
  });

  factory CulqiToken.fromJson(Map<String, dynamic> json) => CulqiToken(
        cardNumber: json["card_number"] == null ? '' : json["card_number"],
        cvv: json["cvv"] == null ? '' : json["cvv"],
        expirationMonth:
            json["expiration_month"] == null ? '' : json["expiration_month"],
        expirationYear:
            json["expiration_year"] == null ? '' : json["expiration_year"],
        email: json["email"] == null ? '' : json["email"],
        metadata: Metadata.fromJson(
            json["metadata"] == null ? {'': ''} : json['metadata']),
      );

  Map<String, dynamic> toJson() => {
        "card_number": cardNumber,
        "cvv": cvv,
        "expiration_month": expirationMonth,
        "expiration_year": expirationYear,
        "email": email,
        "metadata": metadata?.toJson(),
      };
}

class Metadata {
  String? dni;
  String? celular;
  String? orderId;

  Metadata({
    this.dni,
    this.celular,
    this.orderId,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        dni: json["dni"] == null ? '' : json["dni"],
        celular: json["celular"] == null ? '' : json["celular"],
        orderId: json["order_id"] == null ? '' : json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "dni": dni,
        "Celular": celular,
        "order_id": orderId,
      };
}
