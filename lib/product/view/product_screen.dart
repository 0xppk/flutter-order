import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order/common/components/pagination_list_view.dart';
import 'package:order/product/components/product_card.dart';
import 'package:order/product/model/product_model.dart';
import 'package:order/product/provider/product_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: (context, index, item) {
        return GestureDetector(
          onTap: () {
            context.go("/restaurant/${item.restaurant.id}");
          },
          child: ProductCard.fromProductModel(item: item),
        );
      },
    );
  }
}
