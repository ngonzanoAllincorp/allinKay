// To parse this JSON data, do
//
//     final culqiCargoRpt = culqiCargoRptFromJson(jsonString);

import 'dart:convert';

CulqiCargoRpt culqiCargoRptFromJson(String str) =>
    CulqiCargoRpt.fromJson(json.decode(str));

String culqiCargoRptToJson(CulqiCargoRpt data) => json.encode(data.toJson());

class CulqiCargoRpt {
  String? object;
  String? id;
  int? creationDate;
  int? amount;
  int? amountRefunded;
  int? currentAmount;
  int? installments;
  dynamic installmentsAmount;
  String? currencyCode;
  String? email;
  dynamic description;
  Source? source;
  Outcome? outcome;
  dynamic fraudScore;
  AntifraudDetails? antifraudDetails;
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
  String? user_message;
  String? message;
  bool? success;

  CulqiCargoRpt({
    this.object,
    this.id,
    this.creationDate,
    this.amount,
    this.amountRefunded,
    this.currentAmount,
    this.installments,
    this.installmentsAmount,
    this.currencyCode,
    this.email,
    this.description,
    this.source,
    this.outcome,
    this.fraudScore,
    this.antifraudDetails,
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
    this.user_message,
    this.message,
    this.success = false,
  });

  factory CulqiCargoRpt.fromJson(Map<String, dynamic> json) => CulqiCargoRpt(
        object: json["object"],
        id: json["id"],
        creationDate: json["creation_date"],
        amount: json["amount"],
        amountRefunded: json["amount_refunded"],
        currentAmount: json["current_amount"],
        installments: json["installments"],
        installmentsAmount: json["installments_amount"],
        currencyCode: json["currency_code"],
        email: json["email"],
        description: json["description"],
        source: json["source"] == null ? null : Source.fromJson(json["source"]),
        outcome:
            json["outcome"] == null ? null : Outcome.fromJson(json["outcome"]),
        fraudScore: json["fraud_score"],
        antifraudDetails: json["antifraud_details"] == null
            ? null
            : AntifraudDetails.fromJson(json["antifraud_details"]),
        dispute: json["dispute"],
        capture: json["capture"],
        captureDate: json["capture_date"],
        referenceCode: json["reference_code"],
        authorizationCode: json["authorization_code"],
        duplicated: json["duplicated"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        totalFee: json["total_fee"],
        feeDetails: json["fee_details"] == null
            ? null
            : FeeDetails.fromJson(json["fee_details"]),
        totalFeeTaxes: json["total_fee_taxes"],
        transferAmount: json["transfer_amount"],
        paid: json["paid"],
        statementDescriptor: json["statement_descriptor"],
        transferId: json["transfer_id"],
        user_message: json["user_message"],
        message: json["message"],
        success: json["success"],
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
        "antifraud_details": antifraudDetails?.toJson(),
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
        'user_message': user_message,
        'message': message,
        'success': success,
      };
}

class AntifraudDetails {
  String? firstName;
  String? lastName;
  String? address;
  String? addressCity;
  String? countryCode;
  String? phone;
  String? object;

  AntifraudDetails({
    this.firstName,
    this.lastName,
    this.address,
    this.addressCity,
    this.countryCode,
    this.phone,
    this.object,
  });

  factory AntifraudDetails.fromJson(Map<String, dynamic> json) =>
      AntifraudDetails(
        firstName: json["first_name"],
        lastName: json["last_name"],
        address: json["address"],
        addressCity: json["address_city"],
        countryCode: json["country_code"],
        phone: json["phone"],
        object: json["object"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "address": address,
        "address_city": addressCity,
        "country_code": countryCode,
        "phone": phone,
        "object": object,
      };
}

class FeeDetails {
  FixedFee? fixedFee;
  VariableFee? variableFee;

  FeeDetails({
    this.fixedFee,
    this.variableFee,
  });

  factory FeeDetails.fromJson(Map<String, dynamic> json) => FeeDetails(
        fixedFee: json["fixed_fee"] == null
            ? null
            : FixedFee.fromJson(json["fixed_fee"]),
        variableFee: json["variable_fee"] == null
            ? null
            : VariableFee.fromJson(json["variable_fee"]),
      );

  Map<String, dynamic> toJson() => {
        "fixed_fee": fixedFee?.toJson(),
        "variable_fee": variableFee?.toJson(),
      };
}

class FixedFee {
  FixedFee();

  factory FixedFee.fromJson(Map<String, dynamic> json) => FixedFee();

  Map<String, dynamic> toJson() => {};
}

class VariableFee {
  String? currencyCode;
  double? commision;
  int? total;

  VariableFee({
    this.currencyCode,
    this.commision,
    this.total,
  });

  factory VariableFee.fromJson(Map<String, dynamic> json) => VariableFee(
        currencyCode: json["currency_code"],
        commision: json["commision"]?.toDouble(),
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "currency_code": currencyCode,
        "commision": commision,
        "total": total,
      };
}

class Metadata {
  String? celular;
  String? orderId;

  Metadata({
    this.celular,
    this.orderId,
  });

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
        celular: json["Celular"],
        orderId: json["order_id"],
      );

  Map<String, dynamic> toJson() => {
        "Celular": celular,
        "order_id": orderId,
      };
}

class Outcome {
  String? type;
  String? code;
  String? merchantMessage;
  String? userMessage;

  Outcome({
    this.type,
    this.code,
    this.merchantMessage,
    this.userMessage,
  });

  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
        type: json["type"],
        code: json["code"],
        merchantMessage: json["merchant_message"],
        userMessage: json["user_message"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "code": code,
        "merchant_message": merchantMessage,
        "user_message": userMessage,
      };
}

class Source {
  String? object;
  String? id;
  String? type;
  int? creationDate;
  String? email;
  String? cardNumber;
  String? lastFour;
  bool? active;
  Iin? iin;
  Client? client;
  FixedFee? metadata;

  Source({
    this.object,
    this.id,
    this.type,
    this.creationDate,
    this.email,
    this.cardNumber,
    this.lastFour,
    this.active,
    this.iin,
    this.client,
    this.metadata,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        object: json["object"],
        id: json["id"],
        type: json["type"],
        creationDate: json["creation_date"],
        email: json["email"],
        cardNumber: json["card_number"],
        lastFour: json["last_four"],
        active: json["active"],
        iin: json["iin"] == null ? null : Iin.fromJson(json["iin"]),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        metadata: json["metadata"] == null
            ? null
            : FixedFee.fromJson(json["metadata"]),
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
        "iin": iin?.toJson(),
        "client": client?.toJson(),
        "metadata": metadata?.toJson(),
      };
}

class Client {
  String? ip;
  String? ipCountry;
  String? ipCountryCode;
  String? browser;
  dynamic deviceFingerprint;
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
  dynamic cardCategory;
  Issuer? issuer;
  List<dynamic>? installmentsAllowed;

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
            : List<dynamic>.from(json["installments_allowed"]!.map((x) => x)),
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
  dynamic website;
  dynamic phoneNumber;

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
