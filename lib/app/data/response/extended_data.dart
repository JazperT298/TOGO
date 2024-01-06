import 'package:json_annotation/json_annotation.dart';

part 'extended_data.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class ExtendedData {
  bool issubscribed;
  bool othernet;

  ExtendedData({required this.issubscribed, required this.othernet});

  factory ExtendedData.fromJson(Map<String, dynamic> json) => _$ExtendedDataFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendedDataToJson(this);
  List<Object> get props => [issubscribed, othernet];
}
