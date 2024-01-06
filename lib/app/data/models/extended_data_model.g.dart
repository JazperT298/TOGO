// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extended_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExtendedDataModel _$ExtendedDataModelFromJson(Map<String, dynamic> json) =>
    ExtendedDataModel(
      subscribed: json['issubscribed'] as bool,
      otherNet: json['othernet'] as bool,
      subscriberDetails: SubscriberDetails.fromJson(
          json['subscriber-details'] as Map<String, dynamic>),
      transId: json['trans-id'] as String,
      requestId: json['request-id'] as String,
    );

Map<String, dynamic> _$ExtendedDataModelToJson(ExtendedDataModel instance) =>
    <String, dynamic>{
      'issubscribed': instance.subscribed,
      'othernet': instance.otherNet,
      'subscriber-details': instance.subscriberDetails,
      'trans-id': instance.transId,
      'request-id': instance.requestId,
    };
