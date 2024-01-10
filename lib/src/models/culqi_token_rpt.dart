// To parse this JSON data, do
//
//     final culqiTokenRpt = culqiTokenRptFromJson(jsonString);

import 'dart:convert';

CulqiTokenRpt culqiTokenRptFromJson(String str) =>
    CulqiTokenRpt.fromJson(json.decode(str));

String culqiTokenRptToJson(CulqiTokenRpt data) => json.encode(data.toJson());

class CulqiTokenRpt {
  String? object;
  String? id;
  String? type;
  String? email;
  int? creationDate;
  String? cardNumber;
  String? lastFour;
  bool? active;
  Iin? iin;
  Client? client;
  Metadata? metadata;
  String? message;
  bool? success;

  CulqiTokenRpt(
      {this.object,
      this.id,
      this.type,
      this.email,
      this.creationDate,
      this.cardNumber,
      this.lastFour,
      this.active,
      this.iin,
      this.client,
      this.metadata,
      this.message,
      this.success});

  factory CulqiTokenRpt.fromJson(Map<String, dynamic> json) => CulqiTokenRpt(
      object: json["object"],
      id: json["id"],
      type: json["type"],
      email: json["email"],
      creationDate: json["creation_date"],
      cardNumber: json["card_number"],
      lastFour: json["last_four"],
      active: json["active"],
      iin: json["iin"] == null ? null : Iin.fromJson(json["iin"]),
      client: json["client"] == null ? null : Client.fromJson(json["client"]),
      metadata:
          json["metadata"] == null ? null : Metadata.fromJson(json["metadata"]),
      message: json["message"] == null ? '' : json["message"],
      success: json["success"] == null ? false : true);

  Map<String, dynamic> toJson() => {
        "object": object,
        "id": id,
        "type": type,
        "email": email,
        "creation_date": creationDate,
        "card_number": cardNumber,
        "last_four": lastFour,
        "active": active,
        "iin": iin?.toJson(),
        "client": client?.toJson(),
        "metadata": metadata?.toJson(),
        'message': message,
        'success': success
      };
}

class Client {
  String? ip;
  String? ipCountry;
  String? ipCountryCode;
  String? browser;
  String? deviceFingerprint;
  String? deviceType;

  Client({
    this.ip,
    this.ipCountry,
    this.ipCountryCode,
    this.browser,
    this.deviceFingerprint,
    this.deviceType,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        ip: json["ip"],
        ipCountry: json["ip_country"],
        ipCountryCode: json["ip_country_code"],
        browser: json["browser"],
        deviceFingerprint: json["device_fingerprint"],
        deviceType: json["device_type"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip,
        "ip_country": ipCountry,
        "ip_country_code": ipCountryCode,
        "browser": browser,
        "device_fingerprint": deviceFingerprint,
        "device_type": deviceType,
      };
}

class Iin {
  String? object;
  String? bin;
  String? cardBrand;
  String? cardType;
  String? cardCategory;
  Issuer? issuer;
  List<int>? installmentsAllowed;

  Iin({
    this.object,
    this.bin,
    this.cardBrand,
    this.cardType,
    this.cardCategory,
    this.issuer,
    this.installmentsAllowed,
  });

  factory Iin.fromJson(Map<String, dynamic> json) => Iin(
        object: json["object"],
        bin: json["bin"],
        cardBrand: json["card_brand"],
        cardType: json["card_type"],
        cardCategory: json["card_category"],
        issuer: json["issuer"] == null ? null : Issuer.fromJson(json["issuer"]),
        installmentsAllowed: json["installments_allowed"] == null
            ? []
            : List<int>.from(json["installments_allowed"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "bin": bin,
        "card_brand": cardBrand,
        "card_type": cardType,
        "card_category": cardCategory,
        "issuer": issuer?.toJson(),
        "installments_allowed": installmentsAllowed == null
            ? []
            : List<dynamic>.from(installmentsAllowed!.map((x) => x)),
      };
}

class Issuer {
  String? name;
  String? country;
  String? countryCode;
  String? website;
  String? phoneNumber;

  Issuer({
    this.name,
    this.country,
    this.countryCode,
    this.website,
    this.phoneNumber,
  });

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        name: json["name"],
        country: json["country"],
        countryCode: json["country_code"],
        website: json["website"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "country_code": countryCode,
        "website": website,
        "phone_number": phoneNumber,
      };
}

class Metadata {
  String? dni;

  Metadata({
    this.dni,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        dni: json["dni"],
      );

  Map<String, dynamic> toJson() => {
        "dni": dni,
      };
}
