import 'package:ibank/app/data/models/extended_data_model.dart';
import 'package:ibank/app/data/models/subscribers_details.dart';
import 'package:ibank/app/data/response/kyc_inquiry_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class BaseResponse<T> {
  final int responseCode;

  final String responseMessage;

  @JsonKey(fromJson: _dataFromJson, toJson: _dataToJson)
  final T? responseData;

  BaseResponse(this.responseCode, this.responseMessage, this.responseData);

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

T? _dataFromJson<T>(Map<String, dynamic>? json) {
  if (json != null) {
    if (T == KYCInquiryResponse) {
      return KYCInquiryResponse.fromJson(json) as T;
    } else if (T == ExtendedDataModel) {
      return ExtendedDataModel.fromJson(json) as T;
    } else if (T == SubscriberDetails) {
      return SubscriberDetails.fromJson(json) as T;
    } else {
      return null;
    }
  } else {
    return null;
  }
}

Object? _dataToJson<T>(T data) {
  if (data is KYCInquiryResponse) {
    return (data).toJson();
  } else if (data is ExtendedDataModel) {
    return (data).toJson();
  } else if (data is SubscriberDetails) {
    return (data).toJson();
  } else {
    return null;
  }
}
