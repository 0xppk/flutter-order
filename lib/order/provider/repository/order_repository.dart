import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:order/common/const/data.dart';
import 'package:order/common/model/cursor_pagination_model.dart';
import 'package:order/common/model/pagination_params.dart';
import 'package:order/common/repository/base_pagination_repository.dart';
import 'package:order/order/provider/model/order_model.dart';
import 'package:order/order/provider/model/post_order_body.dart';
import 'package:order/provider/dio_provider.dart';
import 'package:retrofit/http.dart';

part 'order_repository.g.dart';

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return OrderRepository(dio, baseUrl: "$baseUrl/order");
});

@RestApi()
abstract class OrderRepository
    implements IBasePaginationRepository<OrderModel> {
  factory OrderRepository(Dio dio, {String baseUrl}) = _OrderRepository;

  @override
  @GET("/")
  @Headers({
    "accessToken": "true",
  })
  Future<CursorPagination<OrderModel>> paginate({
    @Queries() PaginationParams? paginationParams = const PaginationParams(),
  });

  @GET("/")
  @Headers({
    "accessToken": "true",
  })
  Future<List<OrderModel>> getOrder();

  @POST("/")
  @Headers({
    "accessToken": "true",
  })
  Future<OrderModel> postOrder({
    @Body() required PostOrderBody body,
  });
}
