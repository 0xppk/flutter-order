import 'package:flutter/material.dart';
import 'package:order/common/const/colors.dart';
import 'package:order/restaurant/components/restaurant_card.dart';
import 'package:order/restaurant/model/restaurant_detail_model.dart';

class RestaurantDetailCard extends RestaurantCard {
  final List<RestaurantProductModel> products;

  const RestaurantDetailCard({
    super.key,
    required super.image,
    required super.id,
    required super.name,
    required super.tags,
    required super.priceRange,
    required super.ratingsCount,
    required super.ratings,
    required super.deliveryTime,
    required super.deliveryFee,
    super.isDetail = false,
    super.detail,
    required this.products,
  });

  

  factory RestaurantDetailCard.fromModel({
    required RestaurantDetailModel item,
    bool isDetail = false,
  }) {
    return RestaurantDetailCard(
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
      detail: isDetail == true ? item.detail : null,
      products: item.products,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isDetail)
          image
        else
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: image,
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
              if (isDetail)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text("dfdf"),
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
