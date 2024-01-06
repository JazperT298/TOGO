import 'package:ibank/app/data/models/extended_data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'kyc_inquiry_response.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class KYCInquiryResponse {
  @JsonKey(name: "extended-data")
  ExtendedDataModel extendedData;
  KYCInquiryResponse({required this.extendedData});
  factory KYCInquiryResponse.fromJson(Map<String, dynamic> json) => _$KYCInquiryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KYCInquiryResponseToJson(this);

  List<Object> get props => [extendedData];
}
