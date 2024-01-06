import 'package:json_annotation/json_annotation.dart';
part 'kyc_inquiry_request.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class KYCInquiryRequest {
  @JsonKey(name: 'request-id')
  String requestId;

  @JsonKey(name: 'command-id')
  String commandId;

  @JsonKey(name: 'destination')
  String destination;

  KYCInquiryRequest({required this.requestId, required this.commandId, required this.destination});

  factory KYCInquiryRequest.fromJson(Map<String, dynamic> json) => _$KYCInquiryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KYCInquiryRequestToJson(this);

  List<Object> get props => [requestId, commandId, destination];
}
