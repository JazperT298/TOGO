// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResponse _$RegistrationResponseFromJson(
        Map<String, dynamic> json) =>
    RegistrationResponse(
      requestId: json['request-id'] as String,
      transId: json['trans-id'] as String,
      status: json['status'] as String,
      message: json['message'] as String,
      extendedData: ExtendedDataModel.fromJson(
          json['extended-data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegistrationResponseToJson(
        RegistrationResponse instance) =>
    <String, dynamic>{
      'request-id': instance.requestId,
      'trans-id': instance.transId,
      'status': instance.status,
      'message': instance.message,
      'extended-data': instance.extendedData,
    };
