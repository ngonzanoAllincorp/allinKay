import 'dart:convert';

ResponseApi responseApiFromJson(String str) =>
    ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
  String? message;
  dynamic error;
  bool? success;
  dynamic data;
  List<ResponseApi> toList = [];

  ResponseApi({
    this.message,
    this.error,
    this.success,
  });

  ResponseApi.fromJson(Map<String, dynamic> json) {
    message = json["message"];
    error = json["error"];
    success = json["success"];

    try {
      data = json['data'];
    } catch (e) {
      //print(''Exception data $e');
    }
  }
  ResponseApi.fromJsonList(List<dynamic> jsonList) {
    // if (jsonList == null) return;
    if (jsonList.isEmpty) return;
    for (var item in jsonList) {
      ResponseApi rpt = ResponseApi.fromJson(item);
      toList.add(rpt);
    }
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
        "success": success,
        "data": data,
      };
}
