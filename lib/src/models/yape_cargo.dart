// To parse this JSON data, do
//
//     final yapeToken = yapeTokenFromJson(jsonString);

import 'dart:convert';

List<YapeCargo> yapeTokenFromJson(String str) =>
    List<YapeCargo>.from(json.decode(str).map((x) => YapeCargo.fromJson(x)));

String yapeTokenToJson(List<YapeCargo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class YapeCargo {
  String? object;
  String? id;
  int? creationDate;
  int amount;
  int? amountRefunded;
  int? currentAmount;
  int? installments;
  dynamic installmentsAmount;
  String currencyCode;
  String email;
  dynamic description;
  Source? source;
  Outcome? outcome;
  dynamic fraudScore;
  bool? dispute;
  bool? capture;
  int? captureDate;
  String? referenceCode;
  String? authorizationCode;
  bool? duplicated;
  Metadata? metadata;
  int? totalFee;
  FeeDetails? feeDetails;
  int? totalFeeTaxes;
  int? transferAmount;
  bool? paid;
  String? statementDescriptor;
  dynamic transferId;
  String source_id;
  String? message;
  bool success;

  YapeCargo({
    this.object,
    this.id,
    this.creationDate,
    required this.amount,
    this.amountRefunded,
    this.currentAmount,
    this.installments,
    this.installmentsAmount,
    required this.currencyCode,
    required this.email,
    this.description,
    this.source,
    this.outcome,
    this.fraudScore,
    this.dispute,
    this.capture,
    this.captureDate,
    this.referenceCode,
    this.authorizationCode,
    this.duplicated,
    this.metadata,
    this.totalFee,
    this.feeDetails,
    this.totalFeeTaxes,
    this.transferAmount,
    this.paid,
    this.statementDescriptor,
    this.transferId,
    required this.source_id,
    this.message,
    required this.success,
  });

  factory YapeCargo.fromJson(Map<String, dynamic> json) => YapeCargo(
        object: json["object"],
        id: json["id"],
        creationDate: json["creation_date"] == null
            ? 0
            : json["creation_date"] is String
                ? int.parse(json["creation_date"])
                : json["creation_date"],
        amount: json["amount"] == null
            ? 0
            : json["amount"] is String
                ? int.parse(json["amount"])
                : json["amount"],
        amountRefunded: json["amount_refunded"] == null
            ? 0
            : json["amount_refunded"] is String
                ? int.parse(json["amount_refunded"])
                : json["amount_refunded"],
        currentAmount: json["current_amount"] == null
            ? 0
            : json["current_amount"] is String
                ? int.parse(json["current_amount"])
                : json["current_amount"],
        installments: json["installments"] == null
            ? 0
            : json["installments"] is String
                ? int.parse(json["installments"])
                : json["installments"],
        installmentsAmount: json["installments_amount"],
        currencyCode:
            json["currency_code"] == null ? '' : json["currency_code"],
        email: json["email"] == null ? '' : json["email"],
        description: json["description"],
        source: Source.fromJson(
          json["source"] == null ? {'': ''} : json["source"],
        ),
        outcome: Outcome.fromJson(
            json["outcome"] == null ? {'': ''} : json["outcome"]),
        fraudScore: json["fraud_score"],
        dispute: json["dispute"],
        capture: json["capture"],
        captureDate: json["capture_date"] == null
            ? 0
            : json["capture_date"] is String
                ? int.parse(json["capture_date"])
                : json["capture_date"],
        referenceCode: json["reference_code"],
        authorizationCode: json["authorization_code"],
        duplicated: json["duplicated"],
        metadata: Metadata.fromJson(
            json["metadata"] == null ? {'': ''} : json["metadata"]),
        totalFee: json["total_fee"] == null
            ? 0
            : json["total_fee"] is String
                ? int.parse(json["total_fee"])
                : json["total_fee"],
        feeDetails: FeeDetails.fromJson(
            json["fee_details"] == null ? {'': ''} : json["fee_details"]),
        totalFeeTaxes: json["total_fee_taxes"],
        transferAmount: json["transfer_amount"],
        paid: json["paid"],
        statementDescriptor: json["statement_descriptor"],
        transferId: json["transfer_id"],
        source_id: json["source_id"] == null ? '' : json["source_id"],
        message: json["message"] == null ? '' : json["message"],
        success: json["success"] == null ? false : json["success"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "id": id,
        "creation_date": creationDate,
        "amount": amount,
        "amount_refunded": amountRefunded,
        "current_amount": currentAmount,
        "installments": installments,
        "installments_amount": installmentsAmount,
        "currency_code": currencyCode,
        "email": email,
        "description": description,
        "source": source?.toJson(),
        "outcome": outcome?.toJson(),
        "fraud_score": fraudScore,
        "dispute": dispute,
        "capture": capture,
        "capture_date": captureDate,
        "reference_code": referenceCode,
        "authorization_code": authorizationCode,
        "duplicated": duplicated,
        "metadata": metadata?.toJson(),
        "total_fee": totalFee,
        "fee_details": feeDetails?.toJson(),
        "total_fee_taxes": totalFeeTaxes,
        "transfer_amount": transferAmount,
        "paid": paid,
        "statement_descriptor": statementDescriptor,
        "transfer_id": transferId,
        'source_id': source_id,
        'message': message,
        'success': success,
      };
}

class FeeDetails {
  Metadata fixedFee;
  VariableFee variableFee;

  FeeDetails({
    required this.fixedFee,
    required this.variableFee,
  });

  factory FeeDetails.fromJson(Map<String, dynamic> json) => FeeDetails(
        fixedFee: Metadata.fromJson(
            json["fixed_fee"] == null ? {'': ''} : json["fixed_fee"]),
        variableFee: VariableFee.fromJson(
            json["variable_fee"] == null ? {'': ''} : json["variable_fee"]),
      );

  Map<String, dynamic> toJson() => {
        "fixed_fee": fixedFee.toJson(),
        "variable_fee": variableFee.toJson(),
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}

class VariableFee {
  String currencyCode;
  double commision;
  int total;

  VariableFee({
    required this.currencyCode,
    required this.commision,
    required this.total,
  });

  factory VariableFee.fromJson(Map<String, dynamic> json) => VariableFee(
        currencyCode:
            json["currency_code"] == null ? "" : json["currency_code"],
        commision: json["commision"] == null
            ? 0
            : json['commision'] is String
                ? double.parse(json["commision"])
                : isInteger(json["commision"])
                    ? json["commision"].toDouble()
                    : json['commision'],
        total: json["total"] == null
            ? 0
            : json["total"] is String
                ? int.parse(json["total"])
                : json["total"],
      );

  Map<String, dynamic> toJson() => {
        "currency_code": currencyCode,
        "commision": commision,
        "total": total,
      };

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();
}

class Outcome {
  String type;
  String code;
  String merchantMessage;
  String userMessage;

  Outcome({
    required this.type,
    required this.code,
    required this.merchantMessage,
    required this.userMessage,
  });

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
        type: json["type"] == null ? '' : json["type"],
        code: json["code"] == null ? '' : json["code"],
        merchantMessage:
            json["merchant_message"] == null ? '' : json["merchant_message"],
        userMessage: json["user_message"] == null ? '' : json["user_message"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "merchant_message": merchantMessage,
        "user_message": userMessage,
      };
}

class Source {
  String object;
  String id;
  String type;
  int creationDate;
  String email;
  String cardNumber;
  String lastFour;
  bool active;
  Iin iin;
  Client client;
  Metadata metadata;

  Source({
    required this.object,
    required this.id,
    required this.type,
    required this.creationDate,
    required this.email,
    required this.cardNumber,
    required this.lastFour,
    required this.active,
    required this.iin,
    required this.client,
    required this.metadata,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        object: json["object"] == null ? '' : json["object"],
        id: json["id"] == null ? '' : json["id"],
        type: json["type"] == null ? '' : json["type"],
        creationDate: json["creation_date"] == null
            ? 0
            : json["creation_date"] is String
                ? int.parse(json["creation_date"])
                : json["creation_date"],
        email: json["email"] == null ? '' : json["email"],
        cardNumber: json["card_number"] == null ? '' : json["card_number"],
        lastFour: json["last_four"] == null ? '' : json["last_four"],
        active: json["active"] == null ? false : json["active"],
        iin: Iin.fromJson(json["iin"] == null ? {'': ''} : json['iin']),
        client:
            Client.fromJson(json["client"] == null ? {'': ''} : json['client']),
        metadata: Metadata.fromJson(
            json["metadata"] == null ? {'': ''} : json['metadata']),
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "id": id,
        "type": type,
        "creation_date": creationDate,
        "email": email,
        "card_number": cardNumber,
        "last_four": lastFour,
        "active": active,
        "iin": iin.toJson(),
        "client": client.toJson(),
        "metadata": metadata.toJson(),
      };
}

class Client {
  String ip;
  String ipCountry;
  String ipCountryCode;
  String browser;
  dynamic deviceFingerprint;
  String deviceType;

  Client({
    required this.ip,
    required this.ipCountry,
    required this.ipCountryCode,
    required this.browser,
    this.deviceFingerprint,
    required this.deviceType,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        ip: json["ip"] == null ? '' : json["ip"],
        ipCountry: json["ip_country"] == null ? '' : json["ip_country"],
        ipCountryCode:
            json["ip_country_code"] == null ? '' : json["ip_country_code"],
        browser: json["browser"] == null ? '' : json["browser"],
        deviceFingerprint: json["device_fingerprint"] == null
            ? ''
            : json["device_fingerprint"],
        deviceType: json["device_type"] == null ? '' : json["device_type"],
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
  String object;
  String bin;
  String cardBrand;
  String cardType;
  dynamic cardCategory;
  Issuer issuer;
  // List<dynamic> installmentsAllowed;

  Iin({
    required this.object,
    required this.bin,
    required this.cardBrand,
    required this.cardType,
    this.cardCategory,
    required this.issuer,
    // required this.installmentsAllowed,
  });

  factory Iin.fromJson(Map<String, dynamic> json) => Iin(
        object: json["object"] == null ? '' : json["object"],
        bin: json["bin"] == null ? '' : json["bin"],
        cardBrand: json["card_brand"] == null ? '' : json["card_brand"],
        cardType: json["card_type"] == null ? '' : json["card_type"],
        cardCategory:
            json["card_category"] == null ? '' : json["card_category"],
        issuer:
            Issuer.fromJson(json["issuer"] == null ? {'': ''} : json["issuer"]),
        // installmentsAllowed: List<dynamic>.from(
        //     json["installments_allowed"].map((x) => x) == null
        //         ? [
        //             {'': ''}
        //           ]
        //         : json["installments_allowed"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "bin": bin,
        "card_brand": cardBrand,
        "card_type": cardType,
        "card_category": cardCategory,
        "issuer": issuer.toJson(),
        // "installments_allowed":
        //     List<dynamic>.from(installmentsAllowed.map((x) => x)),
      };
}

class Issuer {
  String name;
  String country;
  String countryCode;
  String website;
  String phoneNumber;

  Issuer({
    required this.name,
    required this.country,
    required this.countryCode,
    required this.website,
    required this.phoneNumber,
  });

  factory Issuer.fromJson(Map<String, dynamic> json) => Issuer(
        name: json["name"] == null ? '' : json["name"],
        country: json["country"] == null ? '' : json["country"],
        countryCode: json["country_code"] == null ? '' : json["country_code"],
        website: json["website"] == null ? '' : json["website"],
        phoneNumber: json["phone_number"] == null ? '' : json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "country_code": countryCode,
        "website": website,
        "phone_number": phoneNumber,
      };

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();
}
