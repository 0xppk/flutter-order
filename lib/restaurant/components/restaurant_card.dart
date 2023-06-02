import 'package:flutter/material.dart';
import 'package:order/common/const/colors.dart';
import 'package:order/restaurant/model/restaurant_detail_model.dart';
import 'package:order/restaurant/model/restaurant_model.dart';

class RestaurantCard extends StatelessWidget {
  final Widget image;
  final String id;
  final String name;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final int ratingsCount;
  final double ratings;
  final int deliveryTime;
  final int deliveryFee;
  final bool isDetail;
  final String? detail;

  const RestaurantCard({
    super.key,
    required this.image,
    required this.id,
    required this.name,
    required this.tags,
    required this.priceRange,
    required this.ratingsCount,
    required this.ratings,
    required this.deliveryTime,
    required this.deliveryFee,
    this.isDetail = false,
    this.detail,
  });

  factory RestaurantCard.fromModel({
    required RestaurantModel item,
    bool isDetail = false,
  }) {
    return RestaurantCard(
      id: item.id,
      image: Image.network(
        item.thumbUrl,
        fit: BoxFit.cover,
      ),
      name: item.name,
      priceRange: item.priceRange,
      tags: List<String>.from(item.tags),
      ratingsCount: item.ratingsCount,
      ratings: item.ratings,
      deliveryTime: item.deliveryTime,
      deliveryFee: item.deliveryFee,
      isDetail: isDetail,
      detail: item is RestaurantDetailModel ? item.detail : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: id,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(isDetail ? 0 : 12),
            child: image,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isDetail ? 16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                tags.join("·"),
                style: const TextStyle(
                  color: BODY_TEXT_COLOR,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _IconText(
                    icon: Icons.star,
                    label: ratings.toString(),
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.receipt,
                    label: ratingsCount.toString(),
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.timelapse_outlined,
                    label: "$deliveryTime 분",
                  ),
                  renderDot(),
                  _IconText(
                    icon: Icons.monetization_on,
                    label: deliveryFee == 0 ? "무료" : deliveryFee.toString(),
                  ),
                ],
              ),
              if (detail != null && isDetail)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(detail!),
                )
            ],
          ),
        )
      ],
    );
  }
}

Widget renderDot() {
  return const Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: Text(
      "·",
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class _IconText extends StatelessWidget {
  final IconData icon;
  final String label;

  const _IconText({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(
          icon,
          color: PRIMARY_COLOR,
          size: 14,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
