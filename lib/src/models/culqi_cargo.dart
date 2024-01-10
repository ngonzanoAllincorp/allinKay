import 'dart:convert';

List<CulqiCargo> culqiCargoFromJson(String str) =>
    List<CulqiCargo>.from(json.decode(str).map((x) => CulqiCargo.fromJson(x)));

String culqiCargoToJson(List<CulqiCargo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CulqiCargo {
  String? amount;
  String? currencyCode;
  String? email;
  String? sourceId;
  bool? capture;
  dynamic installments;
  Metadata? metadata;
  AntifraudDetails? antifraudDetails;
  String? description;
  bool? success;

  CulqiCargo({
    this.amount,
    this.currencyCode,
    this.email,
    this.sourceId,
    this.capture,
    this.installments,
    this.metadata,
    this.antifraudDetails,
    this.description,
    this.success,
  });

  factory CulqiCargo.fromJson(Map<String, dynamic> json) => CulqiCargo(
        amount: json["amount"] == null ? '' : json["amount"],
        currencyCode:
            json["currency_code"] == null ? '' : json["currency_code"],
        email: json["email"] == null ? '' : json["email"],
        sourceId: json["source_id"] == null ? '' : json["source_id"],
        capture: json["capture"] == null ? false : true,
        installments:
            json["installments"] == null ? null : json["installments"],
        metadata: Metadata.fromJson(
            json["metadata"] == null ? {'': ''} : json['metadata']),
        antifraudDetails: AntifraudDetails.fromJson(
            json["antifraud_details"] == null
                ? {'': ''}
                : json['antifraud_details']),
        description: json["description"] == null ? '' : json["description"],
        success: json["success"] == null ? false : true,
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currency_code": currencyCode,
        "email": email,
        "source_id": sourceId,
        "capture": capture,
        "installments": installments,
        "metadata": metadata?.toJson(),
        "antifraud_details": antifraudDetails?.toJson(),
        "description": description,
        'success': success
      };
}

class AntifraudDetails {
  String? firstName;
  String? phoneNumber;
  String? address;
  String? lastName;
  String? countryCode;
  String? addressCity;

  AntifraudDetails({
    this.firstName,
    this.phoneNumber,
    this.address,
    this.lastName,
    this.countryCode,
    this.addressCity,
  });

  factory AntifraudDetails.fromJson(Map<String, dynamic> json) =>
      AntifraudDetails(
        firstName: json["first_name"] == null ? '' : json["first_name"],
        phoneNumber: json["phone_number"] == null ? '' : json["phone_number"],
        address: json["address"] == null ? '' : json["address"],
        lastName: json["last_name"] == null ? '' : json["last_name"],
        countryCode: json["country_code"] == null ? '' : json["country_code"],
        addressCity: json["address_city"] == null ? '' : json["address_city"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "phone_number": phoneNumber,
        "address": address,
        "last_name": lastName,
        "country_code": countryCode,
        "address_city": addressCity,
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
