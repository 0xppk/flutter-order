import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/const/colors.dart';
import 'package:order/product/model/product_model.dart';
import 'package:order/restaurant/model/restaurant_detail_model.dart';
import 'package:order/user/provider/basket_provider.dart';

class ProductCard extends ConsumerWidget {
  final Image image;
  final String name;
  final String detail;
  final int price;
  final VoidCallback? onSubtract;
  final VoidCallback? onAdd;
  final String id;

  const ProductCard({
    super.key,
    required this.image,
    required this.name,
    required this.detail,
    required this.price,
    this.onSubtract,
    this.onAdd,
    required this.id,
  });

  factory ProductCard.fromProductModel({
    required ProductModel item,
    final VoidCallback? onSubtract,
    final VoidCallback? onAdd,
  }) {
    return ProductCard(
      image: Image.network(
        item.imgUrl,
        fit: BoxFit.cover,
        width: 120,
        height: 120,
      ),
      name: item.name,
      detail: item.detail,
      price: item.price,
      onSubtract: onSubtract,
      onAdd: onAdd,
      id: item.id,
    );
  }

  factory ProductCard.fromRestaurantProductModel({
    required RestaurantProductModel item,
  }) {
    return ProductCard(
      image: Image.network(
        item.imgUrl,
        fit: BoxFit.cover,
        width: 120,
        height: 120,
      ),
      name: item.name,
      detail: item.detail,
      price: item.price,
      id: item.id,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    return Column(
      children: [
        IntrinsicHeight(
          // 최대 높이를 가진 엘리먼트에 맞춰 모든 요소의 높이가 설정
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: image,
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      detail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: BODY_TEXT_COLOR,
                      ),
                    ),
                    Text(
                      price.toString(),
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 12,
                        color: PRIMARY_COLOR,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (onSubtract != null && onAdd != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: _Footer(
              total: (basket.firstWhere((e) => e.product.id == id).count *
                      basket
                          .firstWhere((e) => e.product.id == id)
                          .product
                          .price)
                  .toString(),
              count: basket.firstWhere((e) => e.product.id == id).count,
              onSubtract: onSubtract!,
              onAdd: onAdd!,
            ),
          )
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  final String total;
  final int count;
  final VoidCallback onSubtract;
  final VoidCallback onAdd;

  const _Footer({
    required this.total,
    required this.count,
    required this.onSubtract,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            "총액 $total원",
            style: const TextStyle(
              color: PRIMARY_COLOR,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          children: [
            renderButton(
              icon: Icons.remove,
              callback: onSubtract,
            ),
            const SizedBox(width: 8),
            Text(
              count.toString(),
              style: const TextStyle(
                color: PRIMARY_COLOR,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            renderButton(
              icon: Icons.add,
              callback: onAdd,
            ),
          ],
        )
      ],
    );
  }
}

Widget renderButton({
  required IconData icon,
  required VoidCallback callback,
}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: PRIMARY_COLOR,
          width: 1,
        )),
    child: InkWell(
      onTap: callback,
      child: Icon(
        icon,
        color: PRIMARY_COLOR,
      ),
    ),
  );
}
