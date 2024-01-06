import 'package:ibank/app/data/models/extended_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'registration_request.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class RegistrationRequest {
  @JsonKey(name: 'request-id')
  String requestId;

  @JsonKey(name: 'command-id')
  String commandId;

  @JsonKey(name: 'destination')
  String destination;
  @JsonKey(name: "extended-data")
  ExtendedDataModel extendedData;

  RegistrationRequest({required this.requestId, required this.commandId, required this.destination, required this.extendedData});

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) => _$RegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationRequestToJson(this);

  List<Object> get props => [requestId, commandId, destination];
}
