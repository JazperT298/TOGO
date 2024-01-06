// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribers_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriberDetails _$SubscriberDetailsFromJson(Map<String, dynamic> json) =>
    SubscriberDetails(
      lastName: json['lastname'] as String,
      firstName: json['firstname'] as String,
      idNumber: json['idnumber'] as String,
      idDescription: json['iddescription'] as String,
      idExpiryDate: json['idexpirydate'] as String,
      gender: json['gender'] as String,
      dateOfBirth: json['dateofbirth'] as String,
      city: json['city'] as String,
      region: json['region'] as String,
      emailAddress: json['emailaddress'] as String,
      alternateMsisdn: json['alternateMsisdn'] as String,
      accountType: json['accounttype'] as String,
    );

Map<String, dynamic> _$SubscriberDetailsToJson(SubscriberDetails instance) =>
    <String, dynamic>{
      'lastname': instance.lastName,
      'firstname': instance.firstName,
      'idnumber': instance.idNumber,
      'iddescription': instance.idDescription,
      'idexpirydate': instance.idExpiryDate,
      'gender': instance.gender,
      'dateofbirth': instance.dateOfBirth,
      'city': instance.city,
      'region': instance.region,
      'emailaddress': instance.emailAddress,
      'alternateMsisdn': instance.alternateMsisdn,
      'accounttype': instance.accountType,
    };
