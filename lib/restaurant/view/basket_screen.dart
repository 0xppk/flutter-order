import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:order/common/const/colors.dart';
import 'package:order/common/layout/root_layout.dart';
import 'package:order/order/provider/order_provider.dart';
import 'package:order/product/components/product_card.dart';
import 'package:order/user/provider/basket_provider.dart';

class BasketScreen extends ConsumerWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    if (basket.isEmpty) {
      return const RootLayout(
        child: Center(
          child: Text("장바구니가 비어 있습니다"),
        ),
      );
    }

    final basketTotal =
        basket.fold(0, (p, n) => p + (n.product.price * n.count));
    final deliverFee = basket.first.product.restaurant.deliveryFee;
    final totalPrice = basketTotal + deliverFee;

    return RootLayout(
      title: "장바구니",
      child: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: basket.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (_, index) {
                    final item = basket[index];

                    return ProductCard.fromProductModel(
                      item: item.product,
                      onAdd: () {
                        ref
                            .read(basketProvider.notifier)
                            .addToBasket(product: item.product);
                      },
                      onSubtract: () {
                        ref
                            .read(basketProvider.notifier)
                            .removeFromBasket(product: item.product);
                      },
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "장바구니 금액",
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      Text(basketTotal.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "배달비",
                        style: TextStyle(
                          color: BODY_TEXT_COLOR,
                        ),
                      ),
                      if (basket.isNotEmpty) Text(deliverFee.toString())
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "총액",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(totalPrice.toString())
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final res =
                            await ref.read(orderProvider.notifier).postOrder();
                        if (res) {
                          context.go("/order_done");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("결제 실패"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: PRIMARY_COLOR,
                      ),
                      child: const Text("결제하기"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
