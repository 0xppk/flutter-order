import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/const/data.dart';
import 'package:order/common/model/cursor_pagination_model.dart';
import 'package:order/common/model/pagination_params.dart';
import 'package:order/common/repository/base_pagination_repository.dart';
import 'package:order/product/model/product_model.dart';
import 'package:order/provider/dio_provider.dart';
import 'package:retrofit/http.dart';

part 'product_repository.g.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductRepository(dio, baseUrl: "$baseUrl/product");
});

@RestApi()
abstract class ProductRepository
    implements IBasePaginationRepository<ProductModel> {
  factory ProductRepository(Dio dio, {String baseUrl}) = _ProductRepository;

  @override
  @GET("/")
  @Headers({"accessToken": "true"})
  Future<CursorPagination<ProductModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });
}
