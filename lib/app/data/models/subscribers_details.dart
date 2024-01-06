import 'package:json_annotation/json_annotation.dart';
part 'subscribers_details.g.dart';
@JsonSerializable(
  fieldRename: FieldRename.none,
)
class SubscriberDetails {
  @JsonKey(name: "lastname")
  String lastName;
  @JsonKey(name: "firstname")
  String firstName;
  @JsonKey(name: "idnumber")
  String idNumber;
  @JsonKey(name: "iddescription")
  String idDescription;
  @JsonKey(name: "idexpirydate")
  String idExpiryDate;
  @JsonKey(name: "gender")
  String gender;
  @JsonKey(name: "dateofbirth")
  String dateOfBirth;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "region")
  String region;
  @JsonKey(name: "emailaddress")
  String emailAddress;
  @JsonKey(name: "alternateMsisdn")
  String alternateMsisdn;
  @JsonKey(name: "accounttype")
  String accountType;
  SubscriberDetails({
    required this.lastName,
    required this.firstName,
    required this.idNumber,
    required this.idDescription,
    required this.idExpiryDate,
    required this.gender,
    required this.dateOfBirth,
    required this.city,
    required this.region,
    required this.emailAddress,
    required this.alternateMsisdn,
    required this.accountType,
  });

  factory SubscriberDetails.fromJson(Map<String, dynamic> json) => _$SubscriberDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriberDetailsToJson(this);

  List<Object> get props =>
      [lastName, firstName, idNumber, idDescription, idExpiryDate, gender, dateOfBirth, city, region, emailAddress, alternateMsisdn, accountType];
}
