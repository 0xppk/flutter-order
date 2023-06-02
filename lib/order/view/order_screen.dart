import 'package:flutter/material.dart';
import 'package:order/common/components/pagination_list_view.dart';
import 'package:order/order/components/order_card.dart';
import 'package:order/order/provider/model/order_model.dart';
import 'package:order/order/provider/order_provider.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationListView<OrderModel>(
      provider: orderProvider,
      itemBuilder: (context, index, model) {
        return OrderCard.fromModel(model: model);
      },
    );
  }
}
