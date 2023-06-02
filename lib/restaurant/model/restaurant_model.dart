import 'package:json_annotation/json_annotation.dart';
import 'package:order/common/model/model_with_id.dart';
import 'package:order/common/utils/data_utils.dart';

part "restaurant_model.g.dart";

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestaurantModel implements IModelWithId {
  @override
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl, // static 함수를 실행하여 그 리턴값을 아래 변수의 값으로 반환
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestaurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestaurantModelToJson(this);

  // static pathToUrl(String path) {
  //   return "http://$ip$path";
  // }

  // 반드시 인스턴스를 리턴해야 함 (스태틱 메써드지만 자식 인스턴스도 리턴 가능)
  // factory RestaurantModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestaurantModel(
  //     thumbUrl: json["thumbUrl"],
  //     name: json["name"],
  //     tags: List<String>.from(json["tags"]),
  //     id: json["id"],
  //     priceRange: RestaurantPriceRange.values.firstWhere(
  //       (e) => e.name == json["priceRange"],
  //     ),
  //     ratingsCount: json["ratingsCount"],
  //     ratings: json["ratings"],
  //     deliveryTime: json["deliveryTime"],
  //     deliveryFee: json["deliveryFee"],
  //   );
  // }
}
