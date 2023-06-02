import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:order/common/components/pagination_list_view.dart';
import 'package:order/restaurant/components/restaurant_card.dart';
import 'package:order/restaurant/model/restaurant_model.dart';
import 'package:order/restaurant/provider/restaurant_provider.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<RestaurantModel>(
      provider: restaurantProvider,
      itemBuilder: (context, index, item) {
        return GestureDetector(
          onTap: () {
            context.go("/restaurant/${item.id}");
          },
          child: RestaurantCard.fromModel(item: item),
        );
      },
    );
  }
}
