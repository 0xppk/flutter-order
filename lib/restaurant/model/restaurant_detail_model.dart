import 'package:json_annotation/json_annotation.dart';
import 'package:order/common/utils/data_utils.dart';
import 'package:order/restaurant/model/restaurant_model.dart';

part "restaurant_detail_model.g.dart";

@JsonSerializable()
class RestaurantDetailModel extends RestaurantModel {
  final String detail;
  final List<RestaurantProductModel> products;

  RestaurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required super.priceRange,
    required this.detail,
    required this.products,
  });

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailModelFromJson(json);

  // factory RestaurantDetailModel.fromJson({
  //   required Map<String, dynamic> item,
  // }) {
  //   return RestaurantDetailModel(
  //     id: item["id"],
  //     name: item["name"],
  //     thumbUrl: item["thumbUrl"],
  //     tags: List<String>.from(item["tags"]),
  //     priceRange: RestaurantPriceRange.values.firstWhere(
  //       (e) => e.name == item["priceRange"],
  //     ),
  //     ratings: item["ratings"],
  //     ratingsCount: item["ratingsCount"],
  //     deliveryTime: item["deliveryTime"],
  //     deliveryFee: item["deliveryFee"],
  //     detail: item["detail"],
  //     products: List<RestaurantProductModel>.from(
  //       item["products"].map(
  //         (product) => RestaurantProductModel.fromJson(product: product),
  //       ),
  //     ),
  //   );
  // }
}

@JsonSerializable()
class RestaurantProductModel {
  final String id;
  final String name;
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });

  // factory RestaurantProductModel.fromJson({
  //   required Map<String, dynamic> product,
  // }) {
  //   return RestaurantProductModel(
  //     id: product["id"],
  //     name: product["name"],
  //     imgUrl: "http://$ip${product["imgUrl"]}",
  //     detail: product["detail"],
  //     price: product["price"],
  //   );
  // }
  // factory RestaurantProductModel.fromJson(Map<String, dynamic> json) =>
  // _$RestaurantProductModelFromJson(json);

  factory RestaurantProductModel.fromJson(Map<String, dynamic> json) =>
      _$RestaurantProductModelFromJson(json);
}
