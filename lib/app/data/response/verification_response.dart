import 'package:ibank/app/data/response/extended_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'verification_response.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class VerificationResponse {
  @JsonKey(name: "extended-data")
  ExtendedData extendedData;

  VerificationResponse({required this.extendedData});

  factory VerificationResponse.fromJson(Map<String, dynamic> json) => _$VerificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VerificationResponseToJson(this);

  List<Object> get props => [extendedData];
}
