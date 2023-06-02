import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/model/cursor_pagination_model.dart';
import 'package:order/order/provider/model/order_model.dart';
import 'package:order/order/provider/model/post_order_body.dart';
import 'package:order/order/provider/repository/order_repository.dart';
import 'package:order/provider/pagination_provider.dart';
import 'package:order/user/provider/basket_provider.dart';
import 'package:uuid/uuid.dart';

final orderProvider =
    StateNotifierProvider<OrderStateNotifier, CursorPaginationBase>(
  (ref) {
    final repo = ref.watch(orderRepositoryProvider);

    return OrderStateNotifier(
      ref: ref,
      repository: repo,
    );
  },
);

class OrderStateNotifier
    extends PaginationProvider<OrderModel, OrderRepository> {
  final Ref ref;
  @override
  OrderStateNotifier({
    required this.ref,
    required super.repository,
  });

  Future<bool> postOrder() async {
    try {
      const uuid = Uuid();
      final id = uuid.v4();
      final state = ref.read(basketProvider);

      await repository.postOrder(
        body: PostOrderBody(
          id: id,
          products: state
              .map(
                (e) => PostOrderBodyProduct(
                  productId: e.product.id,
                  count: e.count,
                ),
              )
              .toList(),
          totalPrice: state.fold(0, (p, n) => p + n.count * n.product.price),
          createdAt: DateTime.now().toString(),
        ),
      );

      return true;
    } catch (e) {
      return false;
    }
  }
}
