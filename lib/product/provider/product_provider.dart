import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/model/cursor_pagination_model.dart';
import 'package:order/product/model/product_model.dart';
import 'package:order/product/repository/product_repository.dart';
import 'package:order/provider/pagination_provider.dart';

final productProvider =
    StateNotifierProvider<ProductStateNotifier, CursorPaginationBase>((ref) {
  final repo = ref.watch(productRepositoryProvider);

  return ProductStateNotifier(repository: repo);
});

class ProductStateNotifier
    extends PaginationProvider<ProductModel, ProductRepository> {
  ProductStateNotifier({
    required super.repository,
  });
}
