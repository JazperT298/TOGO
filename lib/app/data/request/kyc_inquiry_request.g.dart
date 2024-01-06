// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_inquiry_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KYCInquiryRequest _$KYCInquiryRequestFromJson(Map<String, dynamic> json) =>
    KYCInquiryRequest(
      requestId: json['request-id'] as String,
      commandId: json['command-id'] as String,
      destination: json['destination'] as String,
    );

Map<String, dynamic> _$KYCInquiryRequestToJson(KYCInquiryRequest instance) =>
    <String, dynamic>{
      'request-id': instance.requestId,
      'command-id': instance.commandId,
      'destination': instance.destination,
    };
