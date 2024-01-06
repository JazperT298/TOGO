// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_inquiry_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KYCInquiryResponse _$KYCInquiryResponseFromJson(Map<String, dynamic> json) =>
    KYCInquiryResponse(
      extendedData: ExtendedDataModel.fromJson(
          json['extended-data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$KYCInquiryResponseToJson(KYCInquiryResponse instance) =>
    <String, dynamic>{
      'extended-data': instance.extendedData,
    };
