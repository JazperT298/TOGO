import 'package:ibank/app/data/models/subscribers_details.dart';
import 'package:json_annotation/json_annotation.dart';
part 'extended_data_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class ExtendedDataModel {
  @JsonKey(name: "issubscribed")
  bool subscribed;
  @JsonKey(name: "othernet")
  bool otherNet;
  @JsonKey(name: "subscriber-details")
  SubscriberDetails subscriberDetails;
  @JsonKey(name: "trans-id")
  String transId;
  @JsonKey(name: "request-id")
  String requestId;

  ExtendedDataModel(
      {required this.subscribed, required this.otherNet, required this.subscriberDetails, required this.transId, required this.requestId});

  factory ExtendedDataModel.fromJson(Map<String, dynamic> json) => _$ExtendedDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExtendedDataModelToJson(this);

  List<Object> get props => [
        subscribed,
        otherNet,
        subscriberDetails,
        transId,
        requestId,
      ];
}
