// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationRequest _$RegistrationRequestFromJson(Map<String, dynamic> json) =>
    RegistrationRequest(
      requestId: json['request-id'] as String,
      commandId: json['command-id'] as String,
      destination: json['destination'] as String,
      extendedData: ExtendedDataModel.fromJson(
          json['extended-data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegistrationRequestToJson(
        RegistrationRequest instance) =>
    <String, dynamic>{
      'request-id': instance.requestId,
      'command-id': instance.commandId,
      'destination': instance.destination,
      'extended-data': instance.extendedData,
    };
