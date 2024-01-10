// To parse this JSON data, do
//
//     final yapeToken = yapeTokenFromJson(jsonString);

import 'dart:convert';

List<YapeToken> yapeTokenFromJson(String str) =>
    List<YapeToken>.from(json.decode(str).map((x) => YapeToken.fromJson(x)));

String yapeTokenToJson(List<YapeToken> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YapeToken {
  Metadata? metadata;
  String? cardNumber;
  String? lastFour;
  bool? active;
  Client? client;
  String? id;
  int? creationDate;
  String? type;
  String? email;
  String? object;
  Iin? iin;

  String? otp;
  String? number_phone;
  int? amount;
  String? message;
  bool? success;

  YapeToken({
    this.metadata,
    this.cardNumber,
    this.lastFour,
    this.active,
    this.client,
    this.id,
    this.creationDate,
    this.type,
    this.email,
    this.object,
    this.iin,
    required this.otp,
    required this.number_phone,
    required this.amount,
    this.message,
    this.success,
  });

  factory YapeToken.fromJson(Map<String, dynamic> json) => YapeToken(
        metadata: Metadata.fromJson(
            json["metadata"] == null ? {'': ''} : json["metadata"]),
        cardNumber: json["card_number"],
        lastFour: json["last_four"],
        active: json["active"],
        client:
            Client.fromJson(json["client"] == null ? {'': ''} : json["client"]),
        id: json["id"],
        creationDate: json["creation_date"],
        type: json["type"],
        email: json["email"],
        object: json["object"],
        iin: Iin.fromJson(json["iin"] == null ? {'': ''} : json["iin"]),
        otp: json["otp"],
        number_phone: json["number_phone"],
        amount: json["amount"],
        message: json["message"] == null ? '' : json["message"],
        success: json["success"] == null ? false : json["success"],
      );

  Map<String, dynamic> toJson() => {
        "metadata": metadata?.toJson(),
        "card_number": cardNumber,
        "last_four": lastFour,
        "active": active,
        "client": client?.toJson(),
        "id": id,
        "creation_date": creationDate,
        "type": type,
        "email": email,
        "object": object,
        "iin": iin?.toJson(),
        "message": message,
        "success": success,
      };
}

class Client {
  String? deviceFingerprint;
  String? ipCountryCode;
  String? ip;
  String? browser;
  String? ipCountry;
  String? deviceType;

  Client({
    this.deviceFingerprint,
    this.ipCountryCode,
    this.ip,
    this.browser,
    this.ipCountry,
    this.deviceType,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        deviceFingerprint: json["device_fingerprint"] == null
            ? ''
            : json["device_fingerprint"],
        ipCountryCode:
            json["ip_country_code"] == null ? '' : json["ip_country_code"],
        ip: json["ip"] == null ? '' : json['ip'],
        browser: json["browser"] == null ? '' : json['browser'],
        ipCountry: json["ip_country"] == null ? '' : json['ipCountry'],
        deviceType: json["device_type"] == null ? '' : json['device_type'],
      );

  Map<String, dynamic> toJson() => {
        "device_fingerprint": deviceFingerprint,
        "ip_country_code": ipCountryCode,
        "ip": ip,
        "browser": browser,
        "ip_country": ipCountry,
        "device_type": deviceType,
      };
}

class Iin {
  // List<dynamic> installmentsAllowed;
  String? bin;
  dynamic cardCategory;
  String? cardBrand;
  String? cardType;
  Issuer? issuer;
  String? object;

  Iin({
    // required this.installmentsAllowed,
    this.bin,
    this.cardCategory,
    this.cardBrand,
    this.cardType,
    this.issuer,
    this.object,
  });

  factory Iin.fromJson(Map<String, dynamic> json) => Iin(
        // installmentsAllowed:
        //     List<dynamic>.from(json["installments_allowed"].map((x) => x)),
        bin: json["bin"] == null ? '' : json["bin"],
        cardCategory:
            json["card_category"] == null ? '' : json['card_category'],
        cardBrand: json["card_brand"] == null ? '' : json['card_brand'],
        cardType: json["card_type"] == null ? '' : json['card_type'],
        issuer:
            Issuer.fromJson(json["issuer"] == null ? {'': ''} : json['issuer']),
        object: json["object"] == null ? '' : json['object'],
      );

  Map<String, dynamic> toJson() => {
        // "installments_allowed":
        //     List<dynamic>.from(installmentsAllowed.map((x) => x)),
        "bin": bin,
        "card_category": cardCategory,
        "card_brand": cardBrand,
        "card_type": cardType,
        "issuer": issuer?.toJson(),
        "object": object,
      };
}

class Issuer {
  String? country;
  String? countryCode;
  String? website;
  String? name;
  String? phoneNumber;

  Issuer({
    this.country,
    this.countryCode,
    this.website,
    this.name,
    this.phoneNumber,
  });

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        country: json["country"] == null ? '' : json['country'],
        countryCode: json["country_code"] == null ? '' : json['country_code'],
        website: json["website"] == null ? '' : json['website'],
        name: json["name"] == null ? '' : json['name'],
        phoneNumber: json["phone_number"] == null ? '' : json['phone_number'],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "country_code": countryCode,
        "website": website,
        "name": name,
        "phone_number": phoneNumber,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
