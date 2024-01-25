// To parse this JSON data, do
//
//     final internetProducts = internetProductsFromJson(jsonString);

// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

List<BillPayment> BillPaymentFromJson(String str) => List<BillPayment>.from(json.decode(str).map((x) => BillPayment.fromJson(x)));

String BillPaymentToJson(List<BillPayment> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BillPayment {
  List<Message> message;
  String status;

  BillPayment({
    required this.message,
    required this.status,
  });

  factory BillPayment.fromRawJson(String str) => BillPayment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BillPayment.fromJson(Map<String, dynamic> json) => BillPayment(
        message: List<Message>.from(json["message"].map((x) => Message.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": List<dynamic>.from(message.map((x) => x.toJson())),
        "status": status,
      };
}

class Message {
  String frmsisdn;
  String price;
  String productname;
  String description;
  String alias;
  String refid;
  DateTime datepaid;
  String isenabled;
  DateTime dateupload;

  Message({
    required this.frmsisdn,
    required this.price,
    required this.productname,
    required this.description,
    required this.alias,
    required this.refid,
    required this.datepaid,
    required this.isenabled,
    required this.dateupload,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        frmsisdn: json["frmsisdn"],
        price: json["price"],
        productname: json["productname"],
        description: json["description"],
        alias: json["alias"],
        refid: json["refid"],
        datepaid: DateTime.parse(json["datepaid"]),
        isenabled: json["isenabled"],
        dateupload: DateTime.parse(json["dateupload"]),
      );

  Map<String, dynamic> toJson() => {
        "frmsisdn": frmsisdn,
        "price": price,
        "productname": productname,
        "description": description,
        "alias": alias,
        "refid": refid,
        "datepaid": datepaid.toIso8601String(),
        "isenabled": isenabled,
        "dateupload": dateupload.toIso8601String(),
      };
}
