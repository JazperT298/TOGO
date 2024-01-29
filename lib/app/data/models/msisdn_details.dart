// To parse this JSON data, do
//
//     final msisdnDetails = msisdnDetailsFromJson(jsonString);

import 'dart:convert';

MsisdnDetails msisdnDetailsFromJson(String str) => MsisdnDetails.fromJson(json.decode(str));

String msisdnDetailsToJson(MsisdnDetails data) => json.encode(data.toJson());

class MsisdnDetails {
  String altnumber;
  String status;
  String lastname;
  String gender;
  String firstname;
  String email;

  MsisdnDetails({
    required this.altnumber,
    required this.status,
    required this.lastname,
    required this.gender,
    required this.firstname,
    required this.email,
  });

  factory MsisdnDetails.fromJson(Map<String, dynamic> json) => MsisdnDetails(
        altnumber: json["ALTNUMBER"],
        status: json["STATUS"],
        lastname: json["LASTNAME"],
        gender: json["GENDER"],
        firstname: json["FIRSTNAME"],
        email: json["EMAIL"],
      );

  Map<String, dynamic> toJson() => {
        "ALTNUMBER": altnumber,
        "STATUS": status,
        "LASTNAME": lastname,
        "GENDER": gender,
        "FIRSTNAME": firstname,
        "EMAIL": email,
      };
}
