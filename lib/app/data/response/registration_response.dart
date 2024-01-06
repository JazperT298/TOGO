import 'package:ibank/app/data/models/extended_data_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'registration_response.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class RegistrationResponse {
  @JsonKey(name: "request-id")
  String requestId;
  @JsonKey(name: "trans-id")
  String transId;
  @JsonKey(name: "status")
  String status;
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "extended-data")
  ExtendedDataModel extendedData;

  RegistrationResponse({required this.requestId, required this.transId, required this.status, required this.message, required this.extendedData});

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) => _$RegistrationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationResponseToJson(this);

  List<Object> get props => [requestId, transId, status, message, extendedData];
}
